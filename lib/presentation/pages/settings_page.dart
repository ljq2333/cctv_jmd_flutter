import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/usecase_providers.dart';
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
              onChanged: (value) => _updateThemeMode(ref, value!),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('浅色模式'),
              value: AppThemeMode.light,
              groupValue: data.themeMode,
              onChanged: (value) => _updateThemeMode(ref, value!),
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('深色模式'),
              value: AppThemeMode.dark,
              groupValue: data.themeMode,
              onChanged: (value) => _updateThemeMode(ref, value!),
            ),
            const Divider(),
            const _SectionHeader(title: '提醒设置'),
            SwitchListTile(
              title: const Text('启用提醒'),
              value: data.reminderEnabled,
              onChanged: (value) => _updateReminderEnabled(ref, value),
            ),
            ListTile(
              title: const Text('提醒时间'),
              subtitle: Text('节目开始前${data.reminderMinutesBefore}分钟'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showReminderTimePicker(context, ref, data.reminderMinutesBefore),
            ),
            const Divider(),
            const _SectionHeader(title: '缓存管理'),
            ListTile(
              title: const Text('清除缓存'),
              trailing: const Icon(Icons.delete),
              onTap: () => _showClearCacheDialog(context),
            ),
          ],
        ),
        loading: () => const LoadingWidget(message: '加载设置...'),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }

  void _updateThemeMode(WidgetRef ref, AppThemeMode themeMode) {
    final useCase = ref.read(manageSettingsUseCaseProvider);
    useCase.updateThemeMode(themeMode);
    ref.invalidate(userSettingsProvider);
  }

  void _updateReminderEnabled(WidgetRef ref, bool enabled) {
    final useCase = ref.read(manageSettingsUseCaseProvider);
    useCase.updateReminderSettings(enabled: enabled);
    ref.invalidate(userSettingsProvider);
  }

  void _showReminderTimePicker(BuildContext context, WidgetRef ref, int currentMinutes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置提醒时间'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('提前1分钟'),
              onTap: () {
                _updateReminderMinutes(ref, 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('提前3分钟'),
              onTap: () {
                _updateReminderMinutes(ref, 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('提前5分钟'),
              onTap: () {
                _updateReminderMinutes(ref, 5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('提前10分钟'),
              onTap: () {
                _updateReminderMinutes(ref, 10);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('提前15分钟'),
              onTap: () {
                _updateReminderMinutes(ref, 15);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateReminderMinutes(WidgetRef ref, int minutes) {
    final useCase = ref.read(manageSettingsUseCaseProvider);
    useCase.updateReminderSettings(minutesBefore: minutes);
    ref.invalidate(userSettingsProvider);
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除所有缓存数据吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // TODO: 实现清除缓存功能
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('缓存已清除')),
              );
            },
            child: const Text('确定'),
          ),
        ],
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
