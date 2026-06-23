import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';
import 'package:cctv_jmd_flutter/data/models/program_model.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/usecase_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/channel_drawer.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/date_picker_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/program_list_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/error_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _onRefresh() async {
    final channelId = ref.read(currentChannelProvider);
    ref.invalidate(epgDataProvider(channelId));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> _addReminder(Program program, String channelId) async {
    // 先获取用户设置中的提醒时间
    final settingsAsync = ref.read(userSettingsProvider);
    int reminderMinutesBefore = 5;

    settingsAsync.whenData((settings) {
      if (settings.reminderEnabled) {
        reminderMinutesBefore = settings.reminderMinutesBefore;
      }
    });

    final reminder = Reminder(
      id: 'reminder_${DateTime.now().millisecondsSinceEpoch}',
      channelId: channelId,
      title: program.title,
      startTime: program.startTime,
      reminderTime: program.startTime - (reminderMinutesBefore * 60),
      enabled: true,
    );

    final useCase = ref.read(manageRemindersUseCaseProvider);
    final result = await useCase.addReminder(reminder);

    if (mounted) {
      result.fold(
        (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('添加失败: ${failure.message}')),
        ),
        (_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已添加到日程')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final channelId = ref.watch(currentChannelProvider);
    final epgData = ref.watch(epgDataProvider(channelId));
    final currentChannel = ChannelConstants.getChannelById(channelId);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(currentChannel?.name ?? 'CCTV节目单'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
          ),
        ],
      ),
      drawer: const ChannelDrawer(),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            _openDrawer();
          }
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Column(
            children: [
              const DatePickerWidget(),
              Expanded(
                child: epgData.when(
                  data: (data) => ProgramListWidget(
                    programs: data.programs,
                    onFavorite: (program) {},
                    onReminder: (program) => _addReminder(program, channelId),
                  ),
                  loading: () => const LoadingWidget(message: '加载节目单...'),
                  error: (error, stack) => AppErrorWidget(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(epgDataProvider(channelId)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final channel = ChannelConstants.getChannelById(channelId);
                    if (channel != null) {
                      final uri = Uri.parse(channel.liveUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  icon: const Icon(Icons.live_tv),
                  label: const Text('直播入口'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}