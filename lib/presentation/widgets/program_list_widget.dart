import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/program_model.dart';
import 'package:cctv_jmd_flutter/core/utils/date_utils.dart';

class ProgramListWidget extends ConsumerWidget {
  final List<Program> programs;
  final Function(Program)? onFavorite;
  final Function(Program)? onReminder;

  const ProgramListWidget({
    super.key,
    required this.programs,
    this.onFavorite,
    this.onReminder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (programs.isEmpty) {
      return const Center(child: Text('暂无节目信息'));
    }

    return ListView.builder(
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        final startTime = DateTime.fromMillisecondsSinceEpoch(
          program.startTime * 1000,
        );
        final endTime = DateTime.fromMillisecondsSinceEpoch(
          program.endTime * 1000,
        );
        final isCurrent = AppDateUtils.isCurrentProgram(startTime, endTime);

        return ProgramTileWidget(
          program: program,
          isCurrent: isCurrent,
          onFavorite: onFavorite != null ? () => onFavorite!(program) : null,
          onReminder: onReminder != null ? () => onReminder!(program) : null,
        );
      },
    );
  }
}

class ProgramTileWidget extends StatelessWidget {
  final Program program;
  final bool isCurrent;
  final VoidCallback? onFavorite;
  final VoidCallback? onReminder;

  const ProgramTileWidget({
    super.key,
    required this.program,
    this.isCurrent = false,
    this.onFavorite,
    this.onReminder,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isCurrent
          ? Theme.of(context).colorScheme.primaryContainer.withAlpha(80)
          : null,
      leading: Text(
        program.showTime,
        style: TextStyle(
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      title: Text(
        program.title,
        style: TextStyle(
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onFavorite != null)
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: onFavorite,
            ),
          if (onReminder != null)
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: onReminder,
            ),
        ],
      ),
    );
  }
}
