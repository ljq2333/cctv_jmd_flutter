# Data - Repositories 模块任务

## 模块说明
实现所有仓库接口的具体实现，连接数据源和领域层。

---

## 任务清单

### 1. EPG仓库实现
- [ ] 创建 `lib/data/repositories/epg_repository_impl.dart` 文件
- [ ] 实现 `EpgRepositoryImpl` 类
- [ ] 实现 `getEpgData` 方法
- [ ] 实现缓存检查逻辑
- [ ] 实现网络请求逻辑
- [ ] 实现缓存保存逻辑
- [ ] 处理离线情况
- [ ] 添加单元测试

### 2. 收藏仓库实现
- [ ] 创建 `lib/data/repositories/favorites_repository_impl.dart` 文件
- [ ] 实现 `FavoritesRepositoryImpl` 类
- [ ] 实现 `getFavorites` 方法
- [ ] 实现 `saveFavorites` 方法
- [ ] 实现 `addFavorite` 方法
- [ ] 实现 `removeFavorite` 方法
- [ ] 实现 `isFavorite` 方法
- [ ] 添加单元测试

### 3. 提醒仓库实现
- [ ] 创建 `lib/data/repositories/reminders_repository_impl.dart` 文件
- [ ] 实现 `RemindersRepositoryImpl` 类
- [ ] 实现 `getReminders` 方法
- [ ] 实现 `saveReminders` 方法
- [ ] 实现 `addReminder` 方法
- [ ] 实现 `removeReminder` 方法
- [ ] 实现 `updateReminder` 方法
- [ ] 添加单元测试

### 4. 设置仓库实现
- [ ] 创建 `lib/data/repositories/user_settings_repository_impl.dart` 文件
- [ ] 实现 `UserSettingsRepositoryImpl` 类
- [ ] 实现 `getSettings` 方法
- [ ] 实现 `saveSettings` 方法
- [ ] 实现 `updateThemeMode` 方法
- [ ] 实现 `updateLastChannel` 方法
- [ ] 实现 `updateReminderSettings` 方法
- [ ] 添加单元测试

---

## 验收标准
- [ ] 所有仓库实现类创建完成
- [ ] 仓库方法正确调用数据源
- [ ] 缓存逻辑工作正常
- [ ] 错误处理正确
- [ ] 单元测试通过
