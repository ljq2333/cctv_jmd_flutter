# Presentation - Providers 模块任务

## 模块说明
实现Riverpod Providers，管理应用状态和依赖注入。

---

## 任务清单

### 1. 核心Providers
- [x] 创建 `lib/presentation/providers/core_providers.dart` 文件
- [x] 实现 `dioClientProvider`
- [x] 实现 `apiServiceProvider`
- [x] 实现 `storageServiceProvider`
- [x] 实现 `networkInfoProvider`
- [x] 实现 `calendarServiceProvider` (DeviceCalendarService)

### 2. 仓库Providers
- [x] 创建 `lib/presentation/providers/repository_providers.dart` 文件
- [x] 实现 `epgRepositoryProvider`
- [x] 实现 `favoritesRepositoryProvider`
- [x] 实现 `remindersRepositoryProvider`
- [x] 实现 `userSettingsRepositoryProvider`

### 3. 用例Providers
- [x] 创建 `lib/presentation/providers/usecase_providers.dart` 文件
- [x] 实现 `getEpgUseCaseProvider`
- [x] 实现 `searchProgramsUseCaseProvider`
- [x] 实现 `manageFavoritesUseCaseProvider`
- [x] 实现 `manageRemindersUseCaseProvider`
- [x] 实现 `manageSettingsUseCaseProvider`

### 4. 状态Providers
- [x] 创建 `lib/presentation/providers/state_providers.dart` 文件
- [x] 实现 `currentChannelProvider`
- [x] 实现 `selectedDateProvider`
- [x] 实现 `searchQueryProvider`
- [x] 实现 `searchScopeProvider`

### 5. 数据Providers
- [x] 创建 `lib/presentation/providers/data_providers.dart` 文件
- [x] 实现 `epgDataProvider`
- [x] 实现 `favoritesProvider`
- [x] 实现 `remindersProvider`
- [x] 实现 `userSettingsProvider`
- [x] 实现 `searchResultsProvider`

### 6. Provider测试
- [x] 创建测试文件
- [x] 测试核心Providers
- [x] 测试状态Providers
- [x] 测试数据Providers
- [x] 测试Provider依赖关系

---

## 验收标准
- [x] 所有Providers创建完成
- [x] Providers依赖关系正确
- [x] 状态管理正常
- [x] Provider测试通过
- [x] 无循环依赖