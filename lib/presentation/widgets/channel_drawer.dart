import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';

class ChannelDrawer extends ConsumerWidget {
  const ChannelDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChannel = ref.watch(currentChannelProvider);

    return Drawer(
      child: ListView.builder(
        itemCount: ChannelConstants.channels.length,
        itemBuilder: (context, index) {
          final channel = ChannelConstants.channels[index];
          final isSelected = channel.id == currentChannel;

          return ListTile(
            title: Text(
              channel.name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
            selected: isSelected,
            onTap: () {
              ref.read(currentChannelProvider.notifier).state = channel.id;
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
