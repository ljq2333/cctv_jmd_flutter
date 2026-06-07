# Domain - Repositories 模块任务

## 模块说明
定义仓库接口，供领域层使用，实现依赖倒置。

---

## 任务清单

### 1. EPG仓库接口
- [ ] 创建 `lib/domain/repositories/epg_repository.dart` 文件
- [ ] 定义 `EpgRepository` 抽象类
- [ ] 定义 `getEpgData` 方法签名
- [ ] 定义参数类型和返回类型

### 2. 收藏仓库接口
- [ ] 创建 `lib/domain/repositories/favorites_repository.dart` 文件
- [ ] 定义 `FavoritesRepository` 抽象类
- [ ] 定义 `getFavorites` 方法签名
- [ ] 定义 `saveFavorites` 方法签名
- [ ] 定义 `addFavorite` 方法签名
- [ ] 定义 `removeFavorite` 方法签名
- [ ] 定义 `isFavorite` 方法签名

### 3. 提醒仓库接口
- [ ] 创建 `lib/domain/repositories/reminders_repository.dart` 文件
- [ ] 定义 `RemindersRepository` 抽象类
- [ ] 定义 `getReminders` 方法签名
- [ ] 定义 `saveReminders` 方法签名
- [ ] 定义 `addReminder` 方法签名
- [ ] 定义 `removeReminder` 方法签名
- [ ] 定义 `updateReminder` 方法签名

### 4. 设置仓库接口
- [ ] 创建 `lib/domain/repositories/user_settings_repository.dart` 文件
- [ ] 定义 `UserSettingsRepository` 抽象类
- [ ] 定义 `getSettings` 方法签名
- [ ] 定义 `saveSettings` 方法签名

---

## 验收标准
- [ ] 所有仓库接口定义完成
- [ ] 接口方法签名与实现类一致
- [ ] 接口遵循接口隔离原则
- [ ] 无循环依赖
