# Domain - UseCases 模块任务

## 模块说明
实现业务逻辑用例，封装具体的业务规则。

---

## 任务清单

### 1. 获取节目单用例 (GetEpgUseCase)
- [ ] 创建 `lib/domain/usecases/get_epg_usecase.dart` 文件
- [ ] 实现 `GetEpgUseCase` 类
- [ ] 实现 `execute` 方法
- [ ] 处理日期格式化
- [ ] 处理异常情况
- [ ] 添加单元测试

### 2. 搜索节目用例 (SearchProgramsUseCase)
- [ ] 创建 `lib/domain/usecases/search_programs_usecase.dart` 文件
- [ ] 实现 `SearchProgramsUseCase` 类
- [ ] 实现 `execute` 方法
- [ ] 实现当前频道搜索逻辑
- [ ] 实现所有频道搜索逻辑
- [ ] 实现搜索结果排序
- [ ] 添加单元测试

### 3. 管理收藏用例 (ManageFavoritesUseCase)
- [ ] 创建 `lib/domain/usecases/manage_favorites_usecase.dart` 文件
- [ ] 实现 `ManageFavoritesUseCase` 类
- [ ] 实现 `getFavorites` 方法
- [ ] 实现 `addFavorite` 方法
- [ ] 实现 `removeFavorite` 方法
- [ ] 实现 `isFavorite` 方法
- [ ] 处理重复收藏检查
- [ ] 添加单元测试

### 4. 管理提醒用例 (ManageRemindersUseCase)
- [ ] 创建 `lib/domain/usecases/manage_reminders_usecase.dart` 文件
- [ ] 实现 `ManageRemindersUseCase` 类
- [ ] 实现 `getReminders` 方法
- [ ] 实现 `addReminder` 方法
- [ ] 实现 `removeReminder` 方法
- [ ] 实现 `updateReminder` 方法
- [ ] 实现提醒调度逻辑
- [ ] 集成通知服务
- [ ] 集成日历服务
- [ ] 添加单元测试

### 5. 管理设置用例 (ManageSettingsUseCase)
- [ ] 创建 `lib/domain/usecases/manage_settings_usecase.dart` 文件
- [ ] 实现 `ManageSettingsUseCase` 类
- [ ] 实现 `getSettings` 方法
- [ ] 实现 `updateThemeMode` 方法
- [ ] 实现 `updateLastChannel` 方法
- [ ] 实现 `updateReminderSettings` 方法
- [ ] 添加单元测试

---

## 验收标准
- [ ] 所有用例类创建完成
- [ ] 用例方法正确调用仓库
- [ ] 业务逻辑封装在用例中
- [ ] 单元测试通过
- [ ] 用例不依赖具体实现
