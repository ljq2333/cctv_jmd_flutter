# Data - Models 模块任务

## 模块说明
定义所有数据模型，包括节目、频道、收藏、提醒等。

---

## 任务清单

### 1. 节目模型 (Program)
- [ ] 创建 `lib/data/models/program_model.dart` 文件
- [ ] 实现 `Program` 类
- [ ] 定义所有字段（title, startTime, endTime, showTime, length, columnUrl, videoUrl）
- [ ] 实现 `fromJson` 工厂方法
- [ ] 实现 `toJson` 方法
- [ ] 实现 `copyWith` 方法
- [ ] 添加单元测试

### 2. 频道模型 (Channel)
- [ ] 创建 `lib/data/models/channel_model.dart` 文件
- [ ] 实现 `Channel` 类
- [ ] 定义所有字段（id, name, liveUrl, isLive）
- [ ] 实现 `fromJson` 工厂方法
- [ ] 实现 `toJson` 方法
- [ ] 添加单元测试

### 3. 节目单模型 (EpgData)
- [ ] 创建 `lib/data/models/epg_data_model.dart` 文件
- [ ] 实现 `EpgData` 类
- [ ] 定义所有字段（channelId, channelName, date, programs, currentProgram, liveUrl）
- [ ] 实现 `fromJson` 工厂方法
- [ ] 实现 `toJson` 方法
- [ ] 添加单元测试

### 4. 收藏模型 (Favorite)
- [ ] 创建 `lib/data/models/favorite_model.dart` 文件
- [ ] 实现 `Favorite` 类
- [ ] 定义所有字段（id, channelId, channelName, title, startTime, date）
- [ ] 实现 `fromJson` 工厂方法
- [ ] 实现 `toJson` 方法
- [ ] 实现 `copyWith` 方法
- [ ] 添加单元测试

### 5. 提醒模型 (Reminder)
- [ ] 创建 `lib/data/models/reminder_model.dart` 文件
- [ ] 实现 `Reminder` 类
- [ ] 定义所有字段（id, channelId, title, startTime, reminderTime, enabled）
- [ ] 实现 `fromJson` 工厂方法
- [ ] 实现 `toJson` 方法
- [ ] 实现 `copyWith` 方法
- [ ] 添加单元测试

### 6. 用户设置模型 (UserSettings)
- [ ] 创建 `lib/data/models/user_settings_model.dart` 文件
- [ ] 实现 `ThemeMode` 枚举
- [ ] 实现 `ReminderMethod` 枚举
- [ ] 实现 `UserSettings` 类
- [ ] 定义所有字段
- [ ] 实现 `copyWith` 方法
- [ ] 添加单元测试

### 7. 缓存模型 (CacheEntry)
- [ ] 创建 `lib/data/models/cache_entry_model.dart` 文件
- [ ] 实现 `CacheEntry` 类
- [ ] 定义所有字段（key, data, timestamp）
- [ ] 实现 `isExpired` 计算属性
- [ ] 添加单元测试

### 8. 搜索结果模型 (SearchResult)
- [ ] 创建 `lib/data/models/search_result_model.dart` 文件
- [ ] 实现 `SearchResult` 类
- [ ] 定义所有字段（channelId, channelName, program）
- [ ] 添加单元测试

---

## 验收标准
- [ ] 所有模型类创建完成
- [ ] JSON序列化/反序列化正确
- [ ] copyWith方法工作正常
- [ ] 单元测试通过
- [ ] 模型字段与API响应一致
