import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: favorites.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('暂无收藏'));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final favorite = data[index];
              return ListTile(
                title: Text(favorite.title),
                subtitle:
                    Text('${favorite.channelName} ${favorite.date}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
                onTap: () {
                  ref.read(currentChannelProvider.notifier).state =
                      favorite.channelId;
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        loading: () => const LoadingWidget(message: '加载收藏...'),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}
