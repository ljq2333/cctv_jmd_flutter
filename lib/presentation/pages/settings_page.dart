import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: settings.when(
        data: (data) => ListView(
          children: [
            const _SectionHeader(title: '主题模式'),
            RadioListTile<AppThemeMode>(
              title: const Text('跟随系统'),
              value: AppThemeMode.system,
              groupValue: data.themeMode,
              onChanged: (value) {},
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('浅色模式'),
              value: AppThemeMode.light,
              groupValue: data.themeMode,
              onChanged: (value) {},
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('深色模式'),
              value: AppThemeMode.dark,
              groupValue: data.themeMode,
              onChanged: (value) {},
            ),
            const Divider(),
            const _SectionHeader(title: '提醒设置'),
            SwitchListTile(
              title: const Text('启用提醒'),
              value: data.reminderEnabled,
              onChanged: (value) {},
            ),
            ListTile(
              title: const Text('提醒时间'),
              subtitle: Text('节目开始前${data.reminderMinutesBefore}分钟'),
              trailing: const Icon(Icons.chevron_right),
            ),
            const Divider(),
            const _SectionHeader(title: '缓存管理'),
            ListTile(
              title: const Text('清除缓存'),
              trailing: const Icon(Icons.delete),
              onTap: () {},
            ),
          ],
        ),
        loading: () => const LoadingWidget(message: '加载设置...'),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
