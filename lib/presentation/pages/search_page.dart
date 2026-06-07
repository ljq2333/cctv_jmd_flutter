import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cctv_jmd_flutter/presentation/providers/state_providers.dart';
import 'package:cctv_jmd_flutter/presentation/providers/data_providers.dart';
import 'package:cctv_jmd_flutter/presentation/widgets/loading_widget.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = ref.watch(searchScopeProvider);
    final results = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索节目'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '输入节目名称',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<SearchScope>(
                  value: scope,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(searchScopeProvider.notifier).state = value;
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: SearchScope.currentChannel,
                      child: Text('当前频道'),
                    ),
                    DropdownMenuItem(
                      value: SearchScope.allChannels,
                      child: Text('所有频道'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: results.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text('暂无搜索结果'));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final result = data[index];
                    return ListTile(
                      title: Text(result.program.title),
                      subtitle:
                          Text('${result.channelName} ${result.program.showTime}'),
                      onTap: () {
                        ref.read(currentChannelProvider.notifier).state =
                            result.channelId;
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              loading: () => const LoadingWidget(message: '搜索中...'),
              error: (error, stack) => Center(child: Text('搜索失败: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
