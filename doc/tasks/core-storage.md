# Core - Storage 模块任务

## 模块说明
实现本地存储基础设施，使用Hive进行数据持久化。

---

## 任务清单

### 1. Hive初始化
- [ ] 创建 `lib/core/storage/hive_initializer.dart` 文件
- [ ] 实现Hive初始化方法
- [ ] 注册所有Adapter
- [ ] 打开所有Box
- [ ] 处理初始化错误

### 2. 存储服务接口
- [ ] 创建 `lib/core/storage/storage_service.dart` 文件
- [ ] 定义 `StorageService` 抽象类
- [ ] 定义收藏相关方法签名
- [ ] 定义提醒相关方法签名
- [ ] 定义设置相关方法签名
- [ ] 定义缓存相关方法签名

### 3. Hive存储服务实现
- [ ] 创建 `lib/core/storage/hive_storage_service.dart` 文件
- [ ] 实现 `HiveStorageService` 类
- [ ] 实现 `saveFavorites` 方法
- [ ] 实现 `getFavorites` 方法
- [ ] 实现 `saveReminders` 方法
- [ ] 实现 `getReminders` 方法
- [ ] 实现 `saveUserSettings` 方法
- [ ] 实现 `getUserSettings` 方法
- [ ] 实现 `saveCache` 方法
- [ ] 实现 `getCache` 方法
- [ ] 实现 `clearCache` 方法
- [ ] 实现 `getCacheSize` 方法

### 4. 数据迁移
- [ ] 创建 `lib/core/storage/migration.dart` 文件
- [ ] 实现数据版本检查
- [ ] 实现数据迁移逻辑
- [ ] 处理迁移失败情况

---

## 验收标准
- [ ] Hive初始化正常
- [ ] 所有存储操作能正常执行
- [ ] 数据能正确序列化和反序列化
- [ ] 缓存大小计算正确
- [ ] 数据迁移机制工作正常
