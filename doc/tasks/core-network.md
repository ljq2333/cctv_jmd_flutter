# Core - Network 模块任务

## 模块说明
实现网络请求基础设施，包括Dio配置、API服务和JSONP解析。

---

## 任务清单

### 1. Dio客户端配置
- [ ] 创建 `lib/core/network/dio_client.dart` 文件
- [ ] 实现 `DioClient` 类
- [ ] 配置基础URL和超时时间
- [ ] 添加请求拦截器（日志、认证）
- [ ] 添加响应拦截器（错误处理）
- [ ] 实现请求重试机制（指数退避）
- [ ] 实现请求取消功能

### 2. API服务接口
- [ ] 创建 `lib/core/network/api_service.dart` 文件
- [ ] 定义 `ApiService` 抽象类
- [ ] 定义 `getEpgInfo` 方法签名
- [ ] 定义返回类型和参数类型

### 3. CNTV API服务实现
- [ ] 创建 `lib/core/network/cntv_api_service.dart` 文件
- [ ] 实现 `CntvApiService` 类
- [ ] 实现 `getEpgInfo` 方法
- [ ] 实现JSONP响应解析方法
- [ ] 处理API错误和异常
- [ ] 实现请求参数验证

### 4. 网络状态检查
- [ ] 创建 `lib/core/network/network_info.dart` 文件
- [ ] 实现 `NetworkInfo` 类
- [ ] 实现网络连接检查方法
- [ ] 实现网络类型检测

---

## 验收标准
- [ ] Dio客户端配置正确
- [ ] API服务能正常请求CNTV接口
- [ ] JSONP响应能正确解析为JSON
- [ ] 网络错误能正确捕获和处理
- [ ] 请求超时和重试机制工作正常
