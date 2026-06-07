# Presentation - Providers 模块任务

## 模块说明
实现Riverpod Providers，管理应用状态和依赖注入。

---

## 任务清单

### 1. 核心Providers
- [ ] 创建 `lib/presentation/providers/core_providers.dart` 文件
- [ ] 实现 `dioProvider`
- [ ] 实现 `apiServiceProvider`
- [ ] 实现 `storageServiceProvider`
- [ ] 实现 `networkInfoProvider`

### 2. 仓库Providers
- [ ] 创建 `lib/presentation/providers/repository_providers.dart` 文件
- [ ] 实现 `epgRepositoryProvider`
- [ ] 实现 `favoritesRepositoryProvider`
- [ ] 实现 `remindersRepositoryProvider`
- [ ] 实现 `userSettingsRepositoryProvider`

### 3. 用例Providers
- [ ] 创建 `lib/presentation/providers/usecase_providers.dart` 文件
- [ ] 实现 `getEpgUseCaseProvider`
- [ ] 实现 `searchProgramsUseCaseProvider`
- [ ] 实现 `manageFavoritesUseCaseProvider`
- [ ] 实现 `manageRemindersUseCaseProvider`
- [ ] 实现 `manageSettingsUseCaseProvider`

### 4. 状态Providers
- [ ] 创建 `lib/presentation/providers/state_providers.dart` 文件
- [ ] 实现 `currentChannelProvider`
- [ ] 实现 `selectedDateProvider`
- [ ] 实现 `searchQueryProvider`
- [ ] 实现 `searchScopeProvider`

### 5. 数据Providers
- [ ] 创建 `lib/presentation/providers/data_providers.dart` 文件
- [ ] 实现 `epgDataProvider`
- [ ] 实现 `favoritesProvider`
- [ ] 实现 `remindersProvider`
- [ ] 实现 `userSettingsProvider`
- [ ] 实现 `searchResultsProvider`
- [ ] 实现 `cacheSizeProvider`

### 6. Provider测试
- [ ] 创建测试文件
- [ ] 测试核心Providers
- [ ] 测试状态Providers
- [ ] 测试数据Providers
- [ ] 测试Provider依赖关系

---

## 验收标准
- [ ] 所有Providers创建完成
- [ ] Providers依赖关系正确
- [ ] 状态管理正常
- [ ] Provider测试通过
- [ ] 无循环依赖
