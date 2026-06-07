import 'package:cctv_jmd_flutter/core/network/cntv_api_service.dart';
import 'package:cctv_jmd_flutter/data/models/epg_data_model.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final CntvApiService _apiService;

  RemoteDataSourceImpl(this._apiService);

  @override
  Future<EpgData> getEpgInfo({
    required String channelId,
    required String date,
  }) async {
    final response = await _apiService.getEpgInfo(
      channelId: channelId,
      date: date,
    );
    return EpgData.fromJson(response, channelId);
  }
}
