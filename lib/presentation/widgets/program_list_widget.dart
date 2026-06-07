import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/data/models/program_model.dart';
import 'package:cctv_jmd_flutter/core/utils/date_utils.dart';

enum ProgramStatus { live, upcoming, played }

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

    final now = DateTime.now();
    final livePrograms = <Program>[];
    final upcomingPrograms = <Program>[];
    final playedPrograms = <Program>[];

    for (final program in programs) {
      final startTime = DateTime.fromMillisecondsSinceEpoch(
        program.startTime * 1000,
      );
      final endTime = DateTime.fromMillisecondsSinceEpoch(
        program.endTime * 1000,
      );

      if (now.isAfter(startTime) && now.isBefore(endTime)) {
        livePrograms.add(program);
      } else if (now.isBefore(startTime)) {
        upcomingPrograms.add(program);
      } else {
        playedPrograms.add(program);
      }
    }

    return ListView(
      children: [
        if (livePrograms.isNotEmpty) ...[
          _buildSectionHeader(context, '正在直播', Colors.red),
          ...livePrograms.map((p) => _buildProgramTile(context, p, ProgramStatus.live)),
        ],
        if (upcomingPrograms.isNotEmpty) ...[
          _buildSectionHeader(context, '未播', Colors.blue),
          ...upcomingPrograms.map((p) => _buildProgramTile(context, p, ProgramStatus.upcoming)),
        ],
        if (playedPrograms.isNotEmpty) ...[
          _buildSectionHeader(context, '已播', Colors.grey),
          ...playedPrograms.map((p) => _buildProgramTile(context, p, ProgramStatus.played)),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color.withValues(alpha: 0.1),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramTile(BuildContext context, Program program, ProgramStatus status) {
    return ProgramTileWidget(
      program: program,
      status: status,
      onFavorite: onFavorite != null ? () => onFavorite!(program) : null,
      onReminder: onReminder != null ? () => onReminder!(program) : null,
    );
  }
}

class ProgramTileWidget extends StatelessWidget {
  final Program program;
  final ProgramStatus status;
  final VoidCallback? onFavorite;
  final VoidCallback? onReminder;

  const ProgramTileWidget({
    super.key,
    required this.program,
    required this.status,
    this.onFavorite,
    this.onReminder,
  });

  @override
  Widget build(BuildContext context) {
    final startTime = DateTime.fromMillisecondsSinceEpoch(
      program.startTime * 1000,
    );
    final endTime = DateTime.fromMillisecondsSinceEpoch(
      program.endTime * 1000,
    );
    final duration = endTime.difference(startTime);
    final durationText = _formatDuration(duration);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: status == ProgramStatus.live ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: status == ProgramStatus.live
            ? BorderSide(color: Colors.red, width: 2)
            : BorderSide.none,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildTimeColumn(startTime, endTime),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: status == ProgramStatus.live
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: _getTextColor(context),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '时长: $durationText',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(context),
              if (onFavorite != null || onReminder != null) ...[
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onFavorite != null)
                      IconButton(
                        icon: const Icon(Icons.favorite_border, size: 20),
                        onPressed: onFavorite,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (onReminder != null)
                      IconButton(
                        icon: const Icon(Icons.notifications_none, size: 20),
                        onPressed: onReminder,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(DateTime startTime, DateTime endTime) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          Text(
            AppDateUtils.formatToTime(startTime),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: status == ProgramStatus.live ? Colors.red : null,
            ),
          ),
          Container(
            width: 1,
            height: 12,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(vertical: 2),
          ),
          Text(
            AppDateUtils.formatToTime(endTime),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case ProgramStatus.live:
        color = Colors.red;
        text = '直播中';
        break;
      case ProgramStatus.upcoming:
        color = Colors.blue;
        text = '未播';
        break;
      case ProgramStatus.played:
        color = Colors.grey;
        text = '已播';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (status) {
      case ProgramStatus.live:
        return Colors.red.withValues(alpha: 0.05);
      case ProgramStatus.upcoming:
        return null;
      case ProgramStatus.played:
        return Colors.grey.withValues(alpha: 0.05);
    }
  }

  Color? _getTextColor(BuildContext context) {
    switch (status) {
      case ProgramStatus.live:
        return null;
      case ProgramStatus.upcoming:
        return null;
      case ProgramStatus.played:
        return Colors.grey[600];
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours小时${minutes > 0 ? '$minutes分钟' : ''}';
    } else {
      return '$minutes分钟';
    }
  }
}
