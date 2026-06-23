import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';
import 'package:cctv_jmd_flutter/data/models/reminder_model.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/usecase_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/core_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的日程'),
      ),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('暂无订阅的节目', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Text('在节目页面点击提醒按钮添加日程', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            );
          }

          // 按时间排序
          final sortedReminders = List<Reminder>.from(reminders)
            ..sort((a, b) => a.startTime.compareTo(b.startTime));

          return ListView.builder(
            itemCount: sortedReminders.length,
            itemBuilder: (context, index) {
              final reminder = sortedReminders[index];
              return _ReminderTile(
                reminder: reminder,
                onDelete: () => _deleteReminder(context, ref, reminder),
                onToggle: (enabled) => _toggleReminder(context, ref, reminder, enabled),
                onEdit: () => _showEditDialog(context, ref, reminder),
                onAddToCalendar: () => _addToCalendar(context, ref, reminder),
              );
            },
          );
        },
        loading: () => const LoadingWidget(message: '加载日程...'),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('加载失败: $error'),
              TextButton(
                onPressed: () => ref.invalidate(remindersProvider),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteReminder(BuildContext context, WidgetRef ref, Reminder reminder) async {
    final useCase = ref.read(manageRemindersUseCaseProvider);
    await useCase.removeReminder(reminder.id);
    ref.invalidate(remindersProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已删除')),
      );
    }
  }

  Future<void> _toggleReminder(BuildContext context, WidgetRef ref, Reminder reminder, bool enabled) async {
    final useCase = ref.read(manageRemindersUseCaseProvider);
    await useCase.updateReminder(reminder.copyWith(enabled: enabled));
    ref.invalidate(remindersProvider);
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Reminder reminder) {
    final titleController = TextEditingController(text: reminder.title);
    int selectedMinutesBefore = reminder.reminderTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('修改日程'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: '标题',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('提前提醒时间:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [1, 3, 5, 10, 15, 30].map((minutes) {
                  return ChoiceChip(
                    label: Text('$minutes分钟'),
                    selected: selectedMinutesBefore == minutes,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => selectedMinutesBefore = minutes);
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                final useCase = ref.read(manageRemindersUseCaseProvider);
                final newStartTime = reminder.startTime - (selectedMinutesBefore * 60);
                await useCase.updateReminder(reminder.copyWith(
                  title: titleController.text,
                  reminderTime: newStartTime,
                ));
                ref.invalidate(remindersProvider);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已更新')),
                  );
                }
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToCalendar(BuildContext context, WidgetRef ref, Reminder reminder) async {
    try {
      final calendarService = ref.read(calendarServiceProvider);

      // 检查权限
      bool hasPermission = await calendarService.hasPermission();
      if (!hasPermission) {
        final granted = await calendarService.requestPermission();
        if (!granted) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('需要日历权限才能添加到系统日历')),
            );
          }
          return;
        }
      }

      // 获取或创建日历
      String? calendarId = await calendarService.createCalendar('CCTV节目单');
      if (calendarId == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法创建日历')),
          );
        }
        return;
      }

      // 添加事件
      final startTime = DateTime.fromMillisecondsSinceEpoch(reminder.startTime * 1000);
      final endTime = startTime.add(const Duration(hours: 1));
      final channel = ChannelConstants.getChannelById(reminder.channelId);

      final success = await calendarService.addEvent(
        calendarId: calendarId,
        title: reminder.title,
        description: '${channel?.name ?? reminder.channelId} - 提醒',
        startTime: startTime,
        endTime: endTime,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? '已添加到系统日历' : '添加失败')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('添加日历失败: $e')),
        );
      }
    }
  }
}

class _ReminderTile extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onDelete;
  final Function(bool) onToggle;
  final VoidCallback onEdit;
  final VoidCallback onAddToCalendar;

  const _ReminderTile({
    required this.reminder,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
    required this.onAddToCalendar,
  });

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDate(int timestamp) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return '今天';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day + 1) {
      return '明天';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return '昨天';
    } else {
      return '${date.month}月${date.day}日';
    }
  }

  @override
  Widget build(BuildContext context) {
    final channel = ChannelConstants.getChannelById(reminder.channelId);

    return Dismissible(
      key: Key(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          onLongPress: onEdit,
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: reminder.enabled ? Theme.of(context).colorScheme.primaryContainer : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatTime(reminder.startTime),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: reminder.enabled ? null : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            reminder.title,
            style: TextStyle(
              decoration: reminder.enabled ? null : TextDecoration.lineThrough,
              color: reminder.enabled ? null : Colors.grey,
            ),
          ),
          subtitle: Text(
            '${channel?.name ?? reminder.channelId} · ${_formatDate(reminder.startTime)}',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_month, size: 20),
                onPressed: onAddToCalendar,
                tooltip: '添加到日历',
              ),
              Switch(
                value: reminder.enabled,
                onChanged: onToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}