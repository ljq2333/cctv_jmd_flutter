abstract class ApiService {
  Future<Map<String, dynamic>> getEpgInfo({
    required String channelId,
    required String date,
  });
}
