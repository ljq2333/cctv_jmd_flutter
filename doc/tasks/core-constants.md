# Core - Constants 模块任务

## 模块说明
定义应用程序所需的常量，包括频道列表、API配置等。

---

## 任务清单

### 1. 频道常量 (ChannelConstants)
- [ ] 创建 `lib/core/constants/channel_constants.dart` 文件
- [ ] 定义 Channel 模型类（id, name, liveUrl）
- [ ] 实现频道列表常量 `channels`
- [ ] 包含所有CCTV频道（CCTV1-CCTV17）
- [ ] 添加频道ID验证方法

### 2. API常量 (ApiConstants)
- [ ] 创建 `lib/core/constants/api_constants.dart` 文件
- [ ] 定义API基础URL常量
- [ ] 定义API端点常量
- [ ] 定义请求超时时间常量
- [ ] 定义缓存过期时间常量

### 3. 存储常量 (StorageConstants)
- [ ] 创建 `lib/core/constants/storage_constants.dart` 文件
- [ ] 定义Hive Box名称常量
- [ ] 定义存储键名常量
- [ ] 定义缓存前缀常量

### 4. 应用常量 (AppConstants)
- [ ] 创建 `lib/core/constants/app_constants.dart` 文件
- [ ] 定义应用名称常量
- [ ] 定义版本号常量
- [ ] 定义默认设置常量

---

## 验收标准
- [ ] 所有常量文件创建完成
- [ ] 常量值与需求文档一致
- [ ] 无硬编码的魔法数字/字符串
