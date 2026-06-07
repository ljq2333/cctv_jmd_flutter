import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/channel_drawer.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/date_picker_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/program_list_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/error_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelId = ref.watch(currentChannelProvider);
    final epgData = ref.watch(epgDataProvider(channelId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('CCTV节目单'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      drawer: const ChannelDrawer(),
      body: Column(
        children: [
          const DatePickerWidget(),
          Expanded(
            child: epgData.when(
              data: (data) => ProgramListWidget(
                programs: data.programs,
                onFavorite: (program) {},
                onReminder: (program) {},
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
              onPressed: () {
                final channel = ChannelConstants.getChannelById(channelId);
                if (channel != null) {
                  html.window.open(channel.liveUrl, '_blank');
                }
              },
              icon: const Icon(Icons.live_tv),
              label: const Text('直播入口'),
            ),
          ),
        ],
      ),
    );
  }
}
