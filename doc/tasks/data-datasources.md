# Data - DataSources 模块任务

## 模块说明
实现数据源，包括远程数据源和本地数据源。

---

## 任务清单

### 1. 远程数据源接口
- [ ] 创建 `lib/data/datasources/remote_data_source.dart` 文件
- [ ] 定义 `RemoteDataSource` 抽象类
- [ ] 定义 `getEpgInfo` 方法签名

### 2. 远程数据源实现
- [ ] 创建 `lib/data/datasources/remote_data_source_impl.dart` 文件
- [ ] 实现 `RemoteDataSourceImpl` 类
- [ ] 实现 `getEpgInfo` 方法
- [ ] 处理API响应解析
- [ ] 处理网络错误
- [ ] 添加单元测试

### 3. 本地数据源接口
- [ ] 创建 `lib/data/datasources/local_data_source.dart` 文件
- [ ] 定义 `LocalDataSource` 抽象类
- [ ] 定义缓存相关方法签名
- [ ] 定义收藏相关方法签名
- [ ] 定义提醒相关方法签名
- [ ] 定义设置相关方法签名

### 4. 本地数据源实现
- [ ] 创建 `lib/data/datasources/local_data_source_impl.dart` 文件
- [ ] 实现 `LocalDataSourceImpl` 类
- [ ] 实现缓存读写方法
- [ ] 实现收藏读写方法
- [ ] 实现提醒读写方法
- [ ] 实现设置读写方法
- [ ] 添加单元测试

### 5. 缓存数据源
- [ ] 创建 `lib/data/datasources/cache_data_source.dart` 文件
- [ ] 实现 `CacheDataSource` 类
- [ ] 实现内存缓存逻辑
- [ ] 实现缓存过期检查
- [ ] 实现缓存清理
- [ ] 添加单元测试

---

## 验收标准
- [ ] 所有数据源接口和实现类创建完成
- [ ] 远程数据源能正确调用API
- [ ] 本地数据源能正确读写Hive
- [ ] 缓存数据源工作正常
- [ ] 单元测试通过
