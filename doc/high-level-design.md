# CCTV节目单查询软件 - 概要设计文档

## 1. 项目概述

### 1.1 项目目标
基于Flutter开发跨平台CCTV节目单查询应用，支持Android、Windows、Web平台，提供节目单查看、搜索、收藏、提醒等功能。

### 1.2 设计原则
- **单一职责**：每个模块专注单一功能
- **依赖倒置**：上层模块依赖抽象接口，不依赖具体实现
- **关注点分离**：UI、业务逻辑、数据访问分离
- **可测试性**：模块间松耦合，便于单元测试

---

## 2. 系统架构

### 2.1 分层架构图

```
┌─────────────────────────────────────────────────────────────┐
│                      表现层 (Presentation)                   │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ 主页面   │ │ 搜索页面 │ │ 收藏页面 │ │ 设置页面 │       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
├─────────────────────────────────────────────────────────────┤
│                      业务逻辑层 (Business)                   │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ 节目单   │ │ 搜索     │ │ 收藏     │ │ 提醒     │       │
│  │ 状态管理 │ │ 状态管理 │ │ 状态管理 │ │ 状态管理 │       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
├─────────────────────────────────────────────────────────────┤
│                      数据层 (Data)                          │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ API服务  │ │ 缓存服务 │ │ 本地存储 │ │ 通知服务 │       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 各层职责

#### 表现层 (Presentation)
- 负责UI渲染和用户交互
- 接收用户输入，调用业务逻辑层
- 监听状态变化，更新界面

#### 业务逻辑层 (Business)
- 处理业务逻辑和状态管理
- 协调数据层和表现层
- 管理应用状态和业务规则

#### 数据层 (Data)
- 负责数据获取和存储
- API调用和数据转换
- 本地缓存和持久化

---

## 3. 模块划分

### 3.1 模块总览

| 模块名称 | 所属层 | 主要职责 |
|---------|--------|---------|
| API服务模块 | 数据层 | 封装HTTP请求，调用CCTV节目单API |
| 缓存服务模块 | 数据层 | 管理内存缓存和磁盘缓存 |
| 本地存储模块 | 数据层 | 管理SQLite数据库，存储收藏、提醒、设置 |
| 通知服务模块 | 数据层 | 处理系统通知和日历写入 |
| 节目单状态模块 | 业务层 | 管理节目单数据和频道切换 |
| 搜索状态模块 | 业务层 | 管理搜索状态和结果 |
| 收藏状态模块 | 业务层 | 管理收藏数据的增删改查 |
| 提醒状态模块 | 业务层 | 管理提醒设置和调度 |
| 设置状态模块 | 业务层 | 管理用户偏好设置 |
| 主页面模块 | 表现层 | 展示节目列表和日期选择 |
| 侧边栏模块 | 表现层 | 展示频道列表和切换 |
| 搜索页面模块 | 表现层 | 展示搜索界面和结果 |
| 收藏页面模块 | 表现层 | 展示收藏列表 |
| 设置页面模块 | 表现层 | 展示设置选项 |

---

## 4. 模块详细设计

### 4.1 数据层模块

#### 4.1.1 API服务模块 (ApiService)

**职责**：
- 封装Dio HTTP客户端
- 调用CCTV节目单API
- 处理API响应和错误

**接口定义**：
```dart
class ApiService {
  /// 获取指定频道和日期的节目单
  Future<ChannelProgram> getProgram({
    required String channelId,
    required String date,
  });
  
  /// 批量获取多个频道的节目单
  Future<Map<String, ChannelProgram>> getPrograms({
    required List<String> channelIds,
    required String date,
  });
}
```

**依赖**：
- Dio (HTTP客户端)

#### 4.1.2 缓存服务模块 (CacheService)

**职责**：
- 管理内存缓存（LRU策略）
- 管理磁盘缓存（SQLite）
- 缓存过期策略（7天）

**接口定义**：
```dart
class CacheService {
  /// 获取缓存的节目单
  Future<ChannelProgram?> getCachedProgram({
    required String channelId,
    required String date,
  });
  
  /// 缓存节目单数据
  Future<void> cacheProgram({
    required String channelId,
    required String date,
    required ChannelProgram program,
  });
  
  /// 清除所有缓存
  Future<void> clearCache();
  
  /// 获取缓存大小
  Future<int> getCacheSize();
}
```

**依赖**：
- SQLite (本地存储)

#### 4.1.3 本地存储模块 (LocalStorageService)

**职责**：
- 管理SQLite数据库
- 存储收藏、提醒、设置数据
- 提供数据CRUD操作

**接口定义**：
```dart
class LocalStorageService {
  // 收藏相关
  Future<List<Favorite>> getFavorites();
  Future<void> addFavorite(Favorite favorite);
  Future<void> removeFavorite(String id);
  
  // 提醒相关
  Future<List<Reminder>> getReminders();
  Future<void> addReminder(Reminder reminder);
  Future<void> updateReminder(Reminder reminder);
  Future<void> removeReminder(String id);
  
  // 设置相关
  Future<Settings> getSettings();
  Future<void> saveSettings(Settings settings);
}
```

**依赖**：
- SQLite (sqflite包)

#### 4.1.4 通知服务模块 (NotificationService)

**职责**：
- 发送系统推送通知
- 写入系统日历
- 管理应用内提醒

**接口定义**：
```dart
class NotificationService {
  /// 初始化通知服务
  Future<void> initialize();
  
  /// 调度提醒通知
  Future<void> scheduleReminder(Reminder reminder);
  
  /// 取消提醒通知
  Future<void> cancelReminder(String id);
  
  /// 写入系统日历
  Future<void> addToCalendar(CalendarEvent event);
  
  /// 检查通知权限
  Future<bool> checkPermission();
  
  /// 请求通知权限
  Future<bool> requestPermission();
}
```

**依赖**：
- flutter_local_notifications
- device_calendar

---

### 4.2 业务逻辑层模块

#### 4.2.1 节目单状态模块 (ProgramNotifier)

**职责**：
- 管理当前节目单数据
- 处理频道切换
- 处理日期切换
- 协调API和缓存

**状态定义**：
```dart
class ProgramState {
  final String currentChannelId;
  final String currentChannelName;
  final String currentDate;
  final List<Program> programs;
  final bool isLoading;
  final String? error;
}
```

**接口定义**：
```dart
class ProgramNotifier extends StateNotifier<ProgramState> {
  /// 加载节目单
  Future<void> loadProgram({
    required String channelId,
    required String date,
  });
  
  /// 切换频道
  Future<void> switchChannel(String channelId);
  
  /// 切换日期
  Future<void> switchDate(String date);
  
  /// 刷新当前节目单
  Future<void> refresh();
}
```

**依赖**：
- ApiService
- CacheService

#### 4.2.2 搜索状态模块 (SearchNotifier)

**职责**：
- 管理搜索状态
- 执行搜索逻辑
- 管理搜索历史

**状态定义**：
```dart
class SearchState {
  final String query;
  final SearchScope scope; // currentChannel / allChannels
  final List<SearchResult> results;
  final bool isLoading;
  final String? error;
}
```

**接口定义**：
```dart
class SearchNotifier extends StateNotifier<SearchState> {
  /// 执行搜索
  Future<void> search(String query, {SearchScope? scope});
  
  /// 清除搜索结果
  void clearResults();
  
  /// 设置搜索范围
  void setScope(SearchScope scope);
}
```

**依赖**：
- ApiService
- ProgramNotifier (获取当前频道信息)

#### 4.2.3 收藏状态模块 (FavoriteNotifier)

**职责**：
- 管理收藏列表
- 处理收藏的增删操作
- 检查节目是否已收藏

**状态定义**：
```dart
class FavoriteState {
  final List<Favorite> favorites;
  final bool isLoading;
  final String? error;
}
```

**接口定义**：
```dart
class FavoriteNotifier extends StateNotifier<FavoriteState> {
  /// 加载收藏列表
  Future<void> loadFavorites();
  
  /// 添加收藏
  Future<void> addFavorite(Favorite favorite);
  
  /// 删除收藏
  Future<void> removeFavorite(String id);
  
  /// 检查是否已收藏
  bool isFavorite(String channelId, String title, int startTime);
}
```

**依赖**：
- LocalStorageService

#### 4.2.4 提醒状态模块 (ReminderNotifier)

**职责**：
- 管理提醒列表
- 处理提醒的增删改
- 调度系统通知

**状态定义**：
```dart
class ReminderState {
  final List<Reminder> reminders;
  final bool isLoading;
  final String? error;
}
```

**接口定义**：
```dart
class ReminderNotifier extends StateNotifier<ReminderState> {
  /// 加载提醒列表
  Future<void> loadReminders();
  
  /// 添加提醒
  Future<void> addReminder(Reminder reminder);
  
  /// 更新提醒
  Future<void> updateReminder(Reminder reminder);
  
  /// 删除提醒
  Future<void> removeReminder(String id);
  
  /// 启用/禁用提醒
  Future<void> toggleReminder(String id, bool enabled);
}
```

**依赖**：
- LocalStorageService
- NotificationService

#### 4.2.5 设置状态模块 (SettingsNotifier)

**职责**：
- 管理用户设置
- 处理主题切换
- 持久化设置

**状态定义**：
```dart
class SettingsState {
  final ThemeMode themeMode;
  final String lastChannelId;
  final bool reminderEnabled;
  final List<ReminderMethod> reminderMethods;
  final int reminderMinutesBefore;
}
```

**接口定义**：
```dart
class SettingsNotifier extends StateNotifier<SettingsState> {
  /// 加载设置
  Future<void> loadSettings();
  
  /// 更新主题模式
  Future<void> setThemeMode(ThemeMode mode);
  
  /// 更新最后选择的频道
  Future<void> setLastChannel(String channelId);
  
  /// 更新提醒设置
  Future<void> updateReminderSettings({
    bool? enabled,
    List<ReminderMethod>? methods,
    int? minutesBefore,
  });
}
```

**依赖**：
- LocalStorageService

---

### 4.3 表现层模块

#### 4.3.1 主页面模块 (HomePage)

**职责**：
- 展示节目列表
- 日期选择器
- 收藏和提醒操作入口
- 直播入口

**组件结构**：
```
HomePage
├── AppBar (标题、搜索按钮、设置按钮)
├── DatePicker (日期选择)
├── ProgramList (节目列表)
│   └── ProgramItem (单个节目项)
│       ├── 节目信息 (名称、时间、时长)
│       ├── 收藏按钮
│       └── 提醒按钮
└── LiveEntry (直播入口)
```

**依赖**：
- ProgramNotifier
- FavoriteNotifier
- ReminderNotifier

#### 4.3.2 侧边栏模块 (ChannelDrawer)

**职责**：
- 展示频道列表
- 频道切换
- 高亮当前频道

**组件结构**：
```
ChannelDrawer
├── DrawerHeader (标题)
└── ChannelList (频道列表)
    └── ChannelItem (单个频道项)
        └── 频道名称
```

**依赖**：
- ProgramNotifier (获取和切换当前频道)

#### 4.3.3 搜索页面模块 (SearchPage)

**职责**：
- 搜索输入框
- 搜索范围选择
- 搜索结果展示

**组件结构**：
```
SearchPage
├── SearchBar (搜索输入框)
├── ScopeSelector (范围选择)
└── SearchResultList (结果列表)
    └── SearchResultItem (单个结果项)
        ├── 频道名称
        ├── 播出时间
        └── 节目名称
```

**依赖**：
- SearchNotifier

#### 4.3.4 收藏页面模块 (FavoritesPage)

**职责**：
- 展示收藏列表
- 删除收藏
- 点击跳转到对应节目

**组件结构**：
```
FavoritesPage
├── AppBar (标题)
└── FavoriteList (收藏列表)
    └── FavoriteItem (单个收藏项)
        ├── 节目信息 (名称、频道、时间)
        └── 删除按钮
```

**依赖**：
- FavoriteNotifier

#### 4.3.5 设置页面模块 (SettingsPage)

**职责**：
- 主题模式设置
- 提醒设置
- 缓存管理

**组件结构**：
```
SettingsPage
├── AppBar (标题)
├── ThemeSection (主题设置)
│   └── RadioButtonGroup (跟随系统/浅色/深色)
├── ReminderSection (提醒设置)
│   ├── SwitchListTile (启用提醒)
│   ├── CheckboxGroup (提醒方式)
│   └── DropdownButton (提醒时间)
└── CacheSection (缓存管理)
    └── ListTile (清除缓存)
```

**依赖**：
- SettingsNotifier
- CacheService

---

## 5. 数据流设计

### 5.1 节目单加载流程

```
用户选择频道/日期
      ↓
ProgramNotifier.loadProgram()
      ↓
检查缓存 ──→ 缓存命中 ──→ 返回缓存数据
      │
      ↓
缓存未命中
      ↓
ApiService.getProgram()
      ↓
API调用成功 ──→ 更新缓存 ──→ 更新状态 ──→ UI刷新
      │
      ↓
API调用失败
      ↓
尝试加载缓存 ──→ 缓存存在 ──→ 显示缓存数据 + 提示离线
      │
      ↓
缓存不存在 ──→ 显示错误信息
```

### 5.2 搜索流程

```
用户输入搜索关键词
      ↓
SearchNotifier.search()
      ↓
判断搜索范围
      ├── 当前频道 ──→ 从ProgramNotifier获取数据 ──→ 过滤匹配
      │
      └── 所有频道 ──→ 并发请求所有频道数据 ──→ 过滤匹配
      ↓
更新搜索结果 ──→ UI刷新
```

### 5.3 收藏流程

```
用户点击收藏按钮
      ↓
FavoriteNotifier.addFavorite()
      ↓
LocalStorageService.addFavorite()
      ↓
SQLite写入 ──→ 更新状态 ──→ UI刷新
```

### 5.4 提醒流程

```
用户设置提醒
      ↓
ReminderNotifier.addReminder()
      ↓
LocalStorageService.addReminder() ──→ SQLite写入
      ↓
NotificationService.scheduleReminder()
      ├── 系统通知 ──→ 调度本地通知
      ├── 应用内提醒 ──→ 调度应用内弹窗
      └── 写入日历 ──→ 调用日历API
      ↓
更新状态 ──→ UI刷新
```

---

## 6. 技术选型

### 6.1 核心框架
| 类别 | 选择 | 版本 | 说明 |
|------|------|------|------|
| 框架 | Flutter | 3.x | 跨平台UI框架 |
| 语言 | Dart | 3.x | 开发语言 |

### 6.2 状态管理
| 类别 | 选择 | 说明 |
|------|------|------|
| 状态管理 | Riverpod | 类型安全、编译时检查、易于测试 |

### 6.3 数据存储
| 类别 | 选择 | 说明 |
|------|------|------|
| 本地数据库 | SQLite (sqflite) | 结构化数据存储 |
| 轻量存储 | SharedPreferences | 简单键值对存储 |

### 6.4 网络请求
| 类别 | 选择 | 说明 |
|------|------|------|
| HTTP客户端 | Dio | 功能完善、拦截器支持 |

### 6.5 其他依赖
| 类别 | 选择 | 说明 |
|------|------|------|
| 通知 | flutter_local_notifications | 本地通知调度 |
| 日历 | device_calendar | 系统日历集成 |
| 路由 | go_router | 声明式路由管理 |
| 国际化 | flutter_localizations | 多语言支持 |

---

## 7. 异常处理策略

### 7.1 网络异常
- **连接超时**：显示超时提示，提供重试按钮
- **服务器错误**：显示服务器错误提示，记录错误日志
- **无网络**：显示离线提示，加载缓存数据

### 7.2 数据异常
- **JSON解析失败**：记录错误日志，显示默认数据
- **缓存损坏**：清除损坏缓存，重新加载数据
- **数据库异常**：记录错误日志，提示用户重试

### 7.3 权限异常
- **通知权限拒绝**：提示用户开启权限，提供设置入口
- **日历权限拒绝**：提示用户开启权限，提供设置入口

### 7.4 统一错误处理
```dart
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  
  AppException(this.message, {this.code, this.originalError});
}

class ErrorHandler {
  static void handle(AppException exception) {
    // 记录日志
    // 显示用户提示
    // 上报错误（可选）
  }
}
```

---

## 8. 性能优化策略

### 8.1 数据加载优化
- **分页加载**：节目列表按需加载
- **预加载**：预加载相邻日期数据
- **并发请求**：批量获取多个频道数据

### 8.2 缓存策略
- **内存缓存**：LRU缓存最近访问的节目单
- **磁盘缓存**：SQLite缓存7天节目单数据
- **缓存过期**：自动清理过期缓存

### 8.3 UI渲染优化
- **列表虚拟化**：使用ListView.builder懒加载
- **避免重建**：使用const构造函数
- **状态管理**：精确控制重建范围

### 8.4 启动优化
- **异步初始化**：后台初始化服务
- **延迟加载**：非关键资源延迟加载
- **骨架屏**：加载时显示骨架屏

---

## 9. 测试策略

### 9.1 单元测试
- 测试业务逻辑模块
- 测试数据转换函数
- 测试工具类方法

### 9.2 集成测试
- 测试模块间交互
- 测试API调用流程
- 测试数据持久化

### 9.3 Widget测试
- 测试UI组件渲染
- 测试用户交互响应
- 测试状态更新

### 9.4 端到端测试
- 测试完整用户流程
- 测试跨平台兼容性
- 测试性能指标

---

## 10. 部署和发布

### 10.1 构建配置
- **Android**：配置签名、版本号、权限
- **Windows**：配置图标、版本信息
- **Web**：配置PWA、SEO优化

### 10.2 发布流程
1. 代码审查
2. 自动化测试
3. 版本号更新
4. 构建发布包
5. 发布到各平台

---

## 附录A：目录结构

```
lib/
├── main.dart
├── app.dart
├── config/
│   ├── constants.dart
│   ├── themes.dart
│   └── routes.dart
├── models/
│   ├── program.dart
│   ├── channel.dart
│   ├── favorite.dart
│   ├── reminder.dart
│   └── settings.dart
├── services/
│   ├── api_service.dart
│   ├── cache_service.dart
│   ├── local_storage_service.dart
│   └── notification_service.dart
├── providers/
│   ├── program_provider.dart
│   ├── search_provider.dart
│   ├── favorite_provider.dart
│   ├── reminder_provider.dart
│   └── settings_provider.dart
├── pages/
│   ├── home_page.dart
│   ├── search_page.dart
│   ├── favorites_page.dart
│   └── settings_page.dart
├── widgets/
│   ├── channel_drawer.dart
│   ├── program_list.dart
│   ├── program_item.dart
│   ├── date_picker.dart
│   └── live_entry.dart
└── utils/
    ├── date_utils.dart
    ├── format_utils.dart
    └── error_handler.dart
```

---

## 附录B：API接口详情

### 节目单查询接口
```
GET https://api.cntv.cn/epg/getEpgInfoByChannelNew

参数：
- c: 频道ID (如: cctv1)
- serviceId: 服务ID (固定: tvcctv)
- d: 日期 (格式: YYYYMMDD)
- t: 返回格式 (固定: jsonp)
- cb: 回调函数名 (固定: setItem1)

响应：
{
  "data": {
    "频道ID": {
      "channelName": "频道名称",
      "isLive": "当前直播节目名",
      "liveSt": 直播开始时间戳,
      "lvUrl": "直播页面URL",
      "list": [
        {
          "title": "节目名称",
          "startTime": 开始时间戳,
          "endTime": 结束时间戳,
          "showTime": "显示时间",
          "length": 节目时长(秒),
          "column_url": "栏目URL",
          "columnBackvideourl": "视频URL"
        }
      ]
    }
  }
}
```

---

## 附录C：数据库表结构

### 收藏表 (favorites)
```sql
CREATE TABLE favorites (
  id TEXT PRIMARY KEY,
  channel_id TEXT NOT NULL,
  channel_name TEXT NOT NULL,
  title TEXT NOT NULL,
  start_time INTEGER NOT NULL,
  date TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
```

### 提醒表 (reminders)
```sql
CREATE TABLE reminders (
  id TEXT PRIMARY KEY,
  channel_id TEXT NOT NULL,
  title TEXT NOT NULL,
  start_time INTEGER NOT NULL,
  reminder_time INTEGER NOT NULL,
  enabled INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL
);
```

### 缓存表 (program_cache)
```sql
CREATE TABLE program_cache (
  cache_key TEXT PRIMARY KEY,
  data TEXT NOT NULL,
  timestamp INTEGER NOT NULL
);
```

### 设置表 (settings)
```sql
CREATE TABLE settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```
