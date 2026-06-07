import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentChannelProvider = StateProvider<String>((ref) => 'cctv1');

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchScopeProvider = StateProvider<SearchScope>((ref) => SearchScope.currentChannel);

enum SearchScope { currentChannel, allChannels }
