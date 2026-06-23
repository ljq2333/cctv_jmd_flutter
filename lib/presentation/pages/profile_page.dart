import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/user_settings_model.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/usecase_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: ListView(
        children: [
          // 收藏 section
          const _SectionHeader(title: '我的收藏'),
          _FavoritesSection(),
          const Divider(),
          // 设置 section
          const _SectionHeader(title: '设置'),
          _SettingsSection(),
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

class _FavoritesSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return favorites.when(
      data: (data) {
        if (data.isEmpty) {
          return const ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('暂无收藏'),
            subtitle: Text('在节目页面点击收藏按钮添加'),
          );
        }
        return Column(
          children: [
            ...data.take(5).map((favorite) => ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(favorite.title),
                  subtitle: Text(favorite.channelName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _removeFavorite(context, ref, favorite.id),
                  ),
                )),
            if (data.length > 5)
              ListTile(
                leading: const Icon(Icons.arrow_forward),
                title: Text('查看全部收藏 (${data.length})'),
                onTap: () => Navigator.pushNamed(context, '/favorites'),
              ),
          ],
        );
      },
      loading: () => const ListTile(
        leading: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        title: Text('加载中...'),
      ),
      error: (_, __) => ListTile(
        leading: const Icon(Icons.error_outline, color: Colors.red),
        title: const Text('加载失败'),
        onTap: () => ref.invalidate(favoritesProvider),
      ),
    );
  }

  Future<void> _removeFavorite(BuildContext context, WidgetRef ref, String id) async {
    final useCase = ref.read(manageFavoritesUseCaseProvider);
    await useCase.removeFavorite(id);
    ref.invalidate(favoritesProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已取消收藏')),
      );
    }
  }
}

class _SettingsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);

    return settings.when(
      data: (data) => Column(
        children: [
          // 主题模式
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('主题模式'),
            subtitle: Text(_getThemeModeText(data.themeMode)),
            onTap: () => _showThemePicker(context, ref, data.themeMode),
          ),
          // 提醒设置
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('启用提醒'),
            value: data.reminderEnabled,
            onChanged: (value) => _updateReminderEnabled(ref, value),
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('提醒时间'),
            subtitle: Text('节目开始前${data.reminderMinutesBefore}分钟'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showReminderTimePicker(context, ref, data.reminderMinutesBefore),
          ),
          // 缓存管理
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('清除缓存'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showClearCacheDialog(context),
          ),
          // 关于
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('关于'),
            subtitle: const Text('CCTV节目单 v1.0.0'),
          ),
        ],
      ),
      loading: () => const LoadingWidget(message: '加载设置...'),
      error: (error, _) => ListTile(
        leading: const Icon(Icons.error_outline, color: Colors.red),
        title: const Text('加载失败'),
        onTap: () => ref.invalidate(userSettingsProvider),
      ),
    );
  }

  String _getThemeModeText(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => '跟随系统',
      AppThemeMode.light => '浅色模式',
      AppThemeMode.dark => '深色模式',
    };
  }

  void _showThemePicker(BuildContext context, WidgetRef ref, AppThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择主题模式'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<AppThemeMode>(
              title: const Text('跟随系统'),
              value: AppThemeMode.system,
              groupValue: currentMode,
              onChanged: (value) {
                _updateThemeMode(ref, value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('浅色模式'),
              value: AppThemeMode.light,
              groupValue: currentMode,
              onChanged: (value) {
                _updateThemeMode(ref, value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<AppThemeMode>(
              title: const Text('深色模式'),
              value: AppThemeMode.dark,
              groupValue: currentMode,
              onChanged: (value) {
                _updateThemeMode(ref, value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderTimePicker(BuildContext context, WidgetRef ref, int currentMinutes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置提醒时间'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 3, 5, 10, 15].map((minutes) {
            return ListTile(
              title: Text('提前$minutes分钟'),
              trailing: currentMinutes == minutes ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () {
                _updateReminderMinutes(ref, minutes);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
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

  void _updateReminderMinutes(WidgetRef ref, int minutes) {
    final useCase = ref.read(manageSettingsUseCaseProvider);
    useCase.updateReminderSettings(minutesBefore: minutes);
    ref.invalidate(userSettingsProvider);
  }
}