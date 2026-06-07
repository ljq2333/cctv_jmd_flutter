class Channel {
  final String id;
  final String name;
  final String liveUrl;

  const Channel({required this.id, required this.name, required this.liveUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Channel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          liveUrl == other.liveUrl;

  @override
  int get hashCode => Object.hash(id, name, liveUrl);
}

class ChannelConstants {
  ChannelConstants._();

  static const List<Channel> channels = [
    Channel(
      id: 'cctv1',
      name: 'CCTV-1 综合',
      liveUrl: 'https://tv.cctv.com/live/cctv1',
    ),
    Channel(
      id: 'cctv2',
      name: 'CCTV-2 财经',
      liveUrl: 'https://tv.cctv.com/live/cctv2',
    ),
    Channel(
      id: 'cctv3',
      name: 'CCTV-3 综艺',
      liveUrl: 'https://tv.cctv.com/live/cctv3',
    ),
    Channel(
      id: 'cctv4',
      name: 'CCTV-4 中文国际',
      liveUrl: 'https://tv.cctv.com/live/cctv4',
    ),
    Channel(
      id: 'cctveurope',
      name: 'CCTV-4 欧洲',
      liveUrl: 'https://tv.cctv.com/live/cctveurope',
    ),
    Channel(
      id: 'cctvamerica',
      name: 'CCTV-4 美洲',
      liveUrl: 'https://tv.cctv.com/live/cctvamerica',
    ),
    Channel(
      id: 'cctv5',
      name: 'CCTV-5 体育',
      liveUrl: 'https://tv.cctv.com/live/cctv5',
    ),
    Channel(
      id: 'cctv5+',
      name: 'CCTV-5 体育赛事',
      liveUrl: 'https://tv.cctv.com/live/cctv5+',
    ),
    Channel(
      id: 'cctv6',
      name: 'CCTV-6 电影',
      liveUrl: 'https://tv.cctv.com/live/cctv6',
    ),
    Channel(
      id: 'cctv7',
      name: 'CCTV-7 国防军事',
      liveUrl: 'https://tv.cctv.com/live/cctv7',
    ),
    Channel(
      id: 'cctv8',
      name: 'CCTV-8 电视剧',
      liveUrl: 'https://tv.cctv.com/live/cctv8',
    ),
    Channel(
      id: 'cctvjilu',
      name: 'CCTV-9 纪录',
      liveUrl: 'https://tv.cctv.com/live/cctvjilu',
    ),
    Channel(
      id: 'cctv10',
      name: 'CCTV-10 科教',
      liveUrl: 'https://tv.cctv.com/live/cctv10',
    ),
    Channel(
      id: 'cctv11',
      name: 'CCTV-11 戏曲',
      liveUrl: 'https://tv.cctv.com/live/cctv11',
    ),
    Channel(
      id: 'cctv12',
      name: 'CCTV-12 社会与法',
      liveUrl: 'https://tv.cctv.com/live/cctv12',
    ),
    Channel(
      id: 'cctv13',
      name: 'CCTV-13 新闻',
      liveUrl: 'https://tv.cctv.com/live/cctv13',
    ),
    Channel(
      id: 'cctvchild',
      name: 'CCTV-14 少儿',
      liveUrl: 'https://tv.cctv.com/live/cctvchild',
    ),
    Channel(
      id: 'cctv15',
      name: 'CCTV-15 音乐',
      liveUrl: 'https://tv.cctv.com/live/cctv15',
    ),
    Channel(
      id: 'cctv16',
      name: 'CCTV-16 奥林匹克',
      liveUrl: 'https://tv.cctv.com/live/cctv16',
    ),
    Channel(
      id: 'cctv17',
      name: 'CCTV-17 农业农村',
      liveUrl: 'https://tv.cctv.com/live/cctv17',
    ),
  ];

  static final Map<String, Channel> _channelMap = {
    for (final channel in channels) channel.id: channel,
  };

  static bool isValidChannelId(String id) {
    return _channelMap.containsKey(id);
  }

  static Channel? getChannelById(String id) {
    return _channelMap[id];
  }
}
