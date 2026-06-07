import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';

abstract class RemoteDataSource {
  Future<EpgData> getEpgInfo({
    required String channelId,
    required String date,
  });
}
