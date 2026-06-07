import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cctv_jmd_flutter/core/constants/api_constants.dart';
import 'package:cctv_jmd_flutter/core/errors/exceptions.dart';
import 'dio_client.dart';
import 'api_service.dart';

class CntvApiService implements ApiService {
  final DioClient _dioClient;

  CntvApiService(this._dioClient);

  @override
  Future<Map<String, dynamic>> getEpgInfo({
    required String channelId,
    required String date,
    CancelToken? cancelToken,
  }) async {
    if (channelId.isEmpty) {
      throw const ApiException(message: '频道ID不能为空', statusCode: 400);
    }

    if (date.length != 8) {
      throw const ApiException(message: '日期格式无效', statusCode: 400);
    }

    try {
      final response = await _dioClient.get(
        ApiConstants.epgEndpoint,
        queryParameters: {
          'c': channelId,
          'serviceId': ApiConstants.serviceId,
          'd': date,
          't': ApiConstants.defaultFormat,
          'cb': ApiConstants.defaultCallback,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is String) {
          return parseJsonpResponse(data);
        }
        return data as Map<String, dynamic>;
      } else {
        throw ApiException(
          message: '请求失败: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkException(message: '网络连接超时');
      }
      throw ApiException(
        message: e.message ?? '网络请求失败',
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  static Map<String, dynamic> parseJsonpResponse(String jsonp) {
    try {
      final jsonStr = jsonp
          .replaceAll(RegExp(r'^[\w.]*\s*\(?'), '')
          .replaceAll(RegExp(r'\)?\s*;?\s*$'), '');
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      throw const CacheException(message: 'JSONP解析失败');
    }
  }
}
