import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure handleException(Exception exception) {
    if (exception is ApiException) {
      return ApiFailure(message: 'API请求失败: ${exception.message}');
    } else if (exception is CacheException) {
      return CacheFailure(message: '缓存读取失败: ${exception.message}');
    } else if (exception is StorageException) {
      return StorageFailure(message: '存储操作失败: ${exception.message}');
    } else if (exception is NetworkException) {
      return NetworkFailure(message: '网络连接失败: ${exception.message}');
    } else {
      return ApiFailure(message: '未知错误: ${exception.toString()}');
    }
  }

  static String getErrorMessage(Failure failure) {
    if (failure is ApiFailure) {
      return '服务请求失败，请稍后重试';
    } else if (failure is CacheFailure) {
      return '数据加载失败，请检查网络连接';
    } else if (failure is StorageFailure) {
      return '本地存储出现问题，请重试';
    } else if (failure is NetworkFailure) {
      return '网络连接不可用，请检查网络设置';
    } else {
      return '发生未知错误，请重试';
    }
  }
}
