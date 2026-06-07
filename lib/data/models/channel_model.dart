import 'package:cctv_jmd_flutter/core/constants/channel_constants.dart';

class ChannelModel {
  final String id;
  final String name;
  final String liveUrl;
  final String? isLive;

  const ChannelModel({
    required this.id,
    required this.name,
    required this.liveUrl,
    this.isLive,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['channelId'] as String? ?? '',
      name: json['channelName'] as String? ?? '',
      liveUrl: json['lvUrl'] as String? ?? '',
      isLive: json['isLive'] as String?,
    );
  }

  factory ChannelModel.fromConstants(Channel channel) {
    return ChannelModel(
      id: channel.id,
      name: channel.name,
      liveUrl: channel.liveUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channelId': id,
      'channelName': name,
      'lvUrl': liveUrl,
      'isLive': isLive,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => Object.hash(id, name);
}
