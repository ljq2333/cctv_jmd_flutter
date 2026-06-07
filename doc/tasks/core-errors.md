# Core - Errors 模块任务

## 模块说明
定义统一的错误处理机制，包括自定义异常类和错误处理工具。

---

## 任务清单

### 1. 自定义异常类
- [ ] 创建 `lib/core/errors/exceptions.dart` 文件
- [ ] 实现 `ApiException` 类（message, statusCode）
- [ ] 实现 `CacheException` 类
- [ ] 实现 `StorageException` 类
- [ ] 实现 `NetworkException` 类
- [ ] 为每个异常类添加 toString() 方法

### 2. 失败类 (Failure)
- [ ] 创建 `lib/core/errors/failures.dart` 文件
- [ ] 实现抽象 `Failure` 基类
- [ ] 实现 `ApiFailure` 类
- [ ] 实现 `CacheFailure` 类
- [ ] 实现 `StorageFailure` 类
- [ ] 实现 `NetworkFailure` 类

### 3. 错误处理器
- [ ] 创建 `lib/core/errors/error_handler.dart` 文件
- [ ] 实现 `ErrorHandler` 类
- [ ] 实现异常转Failure方法
- [ ] 实现错误日志记录方法
- [ ] 实现用户友好错误消息生成

---

## 验收标准
- [ ] 所有异常类创建完成
- [ ] 异常类支持序列化
- [ ] 错误处理器能正确转换异常为Failure
- [ ] 错误消息用户友好
