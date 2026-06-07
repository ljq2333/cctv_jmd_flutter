# CCTV节目单查询软件 - 详细设计文档

## 1. 概述

### 1.1 文档目的
本文档基于需求文档 `proposal.md`，对CCTV节目单查询软件进行详细设计，确保模块之间保持"高内聚、低耦合"的原则，并支持独立的单元测试。

### 1.2 设计原则
- **单一职责原则**：每个模块/类只负责一项功能
- **依赖倒置原则**：高层模块不依赖低层模块，二者都依赖抽象
- **接口隔离原则**：使用多个特定接口而非单一宽接口
- **开闭原则**：对扩展开放，对修改关闭
- **高内聚、低耦合**：模块内部紧密相关，模块之间松散连接

---

## 2. 架构设计

### 2.1 整体架构
采用 **Clean Architecture** 分层架构，结合 **Riverpod** 进行状态管理和依赖注入。

```
┌─────────────────────────────────────┐
│           UI Layer                  │
│  (Pages, Widgets, ViewModels)       │
├─────────────────────────────────────┤
│         Domain Layer                │
│  (Business Logic, Use Cases)        │
├─────────────────────────────────────┤
│          Data Layer                 │
│  (Repositories, Data Sources)       │
├─────────────────────────────────────┤
│        Core/Infrastructure          │
│  (API Client, Storage, Notifications)│
└─────────────────────────────────────┘
```

### 2.2 技术选型
| 层级 | 技术方案 | 说明 |
|------|----------|------|
| 状态管理 | Riverpod | 提供依赖注入、状态管理、易于测试 |
| 网络请求 | Dio | 支持拦截器、错误处理、请求取消 |
| 本地存储 | Hive | 高性能键值对存储，支持复杂对象 |
| 通知服务 | flutter_local_notifications | 跨平台本地通知 |
| 日历集成 | device_calendar | 系统日历读写 |
| 路由管理 | go_router | 声明式路由，支持深链接 |

---

## 3. 模块划分

### 3.1 模块总览
```
lib/
├── core/                    # 核心基础设施
│   ├── constants/          # 常量定义
│   ├── errors/             # 错误处理
│   ├── network/            # 网络层
│   ├── storage/            # 存储层
│   └── utils/              # 工具类
├── data/                    # 数据层
│   ├── models/             # 数据模型
│   ├── repositories/       # 仓库实现
│   └── datasources/        # 数据源
├── domain/                  # 领域层
│   ├── entities/           # 实体
│   ├── repositories/       # 仓库接口
│   └── usecases/           # 用例
├── presentation/            # 表现层
│   ├── pages/              # 页面
│   ├── widgets/            # 组件
│   └── providers/          # Riverpod Providers
└── services/                # 服务层
    ├── notification/       # 通知服务
    ├── calendar/           # 日历服务
    └── cache/              # 缓存服务
```

### 3.2 模块依赖关系图
```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ HomePage │ │ Search   │ │ Favorites│ │ Settings │       │
│  │ Page     │ │ Page     │ │ Page     │ │ Page     │       │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘       │
│       │            │            │            │              │
│  ┌────┴────────────┴────────────┴────────────┴─────┐       │
│  │              Providers (Riverpod)                │       │
│  └────┬────────────┬────────────┬────────────┬─────┘       │
└───────┼────────────┼────────────┼────────────┼──────────────┘
        │            │            │            │
┌───────┼────────────┼────────────┼────────────┼──────────────┐
│       │      Domain Layer       │            │              │
│  ┌────┴─────┐ ┌────┴─────┐ ┌────┴─────┐ ┌────┴─────┐       │
│  │ GetEpg   │ │ Search   │ │ Manage   │ │ Manage   │       │
│  │ UseCase  │ │ UseCase  │ │ Favorites│ │ Settings │       │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘       │
│       │            │            │            │              │
│  ┌────┴────────────┴────────────┴────────────┴─────┐       │
│  │           Repository Interfaces                 │       │
│  └────┬────────────┬────────────┬────────────┬─────┘       │
└───────┼────────────┼────────────┼────────────┼──────────────┘
        │            │            │            │
┌───────┼────────────┼────────────┼────────────┼──────────────┐
│       │       Data Layer        │            │              │
│  ┌────┴─────┐ ┌────┴─────┐ ┌────┴─────┐ ┌────┴─────┐       │
│  │ Epg      │ │ Search   │ │ Favorites│ │ Settings │       │
│  │ Repository│ │ Repository│ │ Repository│ │ Repository│     │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘       │
│       │            │            │            │              │
│  ┌────┴────────────┴────────────┴────────────┴─────┐       │
│  │              Data Sources                       │       │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐        │       │
│  │  │ Remote   │ │ Local    │ │ Cache    │        │       │
│  │  │ DataSource│ │ DataSource│ │ DataSource│       │       │
│  │  └──────────┘ └──────────┘ └──────────┘        │       │
│  └────────────────────────────────────────────────┘       │
└──────────────────────────────────────────────────────────────┘
        │
┌───────┼──────────────────────────────────────────────────────┐
│       │          Core/Infrastructure                         │
│  ┌────┴─────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ Dio      │ │ Hive     │ │ Notification│ │ Calendar│      │
│  │ Client   │ │ Storage  │ │ Service  │ │ Service  │       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
└──────────────────────────────────────────────────────────────┘
```

---

## 4. 数据模型设计

### 4.1 核心数据模型

#### 4.1.1 节目模型 (Program)
```dart
// lib/data/models/program_model.dart
class Program {
  final String title;           // 节目名称
  final int startTime;          // 开始时间戳
  final int endTime;            // 结束时间戳
  final String showTime;        // 显示时间 (HH:mm)
  final int length;             // 时长（秒）
  final String? columnUrl;      // 栏目URL
  final String? videoUrl;       // 视频URL

  Program({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.showTime,
    required this.length,
    this.columnUrl,
    this.videoUrl,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      title: json['title'] as String,
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      showTime: json['showTime'] as String,
      length: json['length'] as int,
      columnUrl: json['column_url'] as String?,
      videoUrl: json['columnBackvideourl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'showTime': showTime,
      'length': length,
      'column_url': columnUrl,
      'columnBackvideourl': videoUrl,
    };
  }
}
```

#### 4.1.2 频道模型 (Channel)
```dart
// lib/data/models/channel_model.dart
class Channel {
  final String id;              // 频道ID (cctv1, cctv2, ...)
  final String name;            // 频道名称
  final String? liveUrl;        // 直播URL
  final bool isLive;            // 是否正在直播

  Channel({
    required this.id,
    required this.name,
    this.liveUrl,
    this.isLive = false,
  });

  factory Channel.fromJson(String id, Map<String, dynamic> json) {
    return Channel(
      id: id,
      name: json['channelName'] as String,
      liveUrl: json['lvUrl'] as String?,
      isLive: json['isLive'] != null && (json['isLive'] as String).isNotEmpty,
    );
  }
}
```

#### 4.1.3 节目单模型 (EpgData)
```dart
// lib/data/models/epg_data_model.dart
class EpgData {
  final String channelId;
  final String channelName;
  final String date;
  final List<Program> programs;
  final String? currentProgram;
  final int? currentProgramStartTime;
  final String? liveUrl;

  EpgData({
    required this.channelId,
    required this.channelName,
    required this.date,
    required this.programs,
    this.currentProgram,
    this.currentProgramStartTime,
    this.liveUrl,
  });
}
```

#### 4.1.4 收藏模型 (Favorite)
```dart
// lib/data/models/favorite_model.dart
class Favorite {
  final String id;              // 唯一标识
  final String channelId;       // 频道ID
  final String channelName;     // 频道名称
  final String title;           // 节目名称
  final int startTime;          // 开始时间戳
  final String date;            // 日期 (yyyyMMdd)

  Favorite({
    required this.id,
    required this.channelId,
    required this.channelName,
    required this.title,
    required this.startTime,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'channelId': channelId,
    'channelName': channelName,
    'title': title,
    'startTime': startTime,
    'date': date,
  };

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json['id'] as String,
    channelId: json['channelId'] as String,
    channelName: json['channelName'] as String,
    title: json['title'] as String,
    startTime: json['startTime'] as int,
    date: json['date'] as String,
  );
}
```

#### 4.1.5 提醒模型 (Reminder)
```dart
// lib/data/models/reminder_model.dart
class Reminder {
  final String id;              // 唯一标识
  final String channelId;       // 频道ID
  final String title;           // 节目名称
  final int startTime;          // 开始时间戳
  final int reminderTime;       // 提醒时间戳
  final bool enabled;           // 是否启用

  Reminder({
    required this.id,
    required this.channelId,
    required this.title,
    required this.startTime,
    required this.reminderTime,
    this.enabled = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'channelId': channelId,
    'title': title,
    'startTime': startTime,
    'reminderTime': reminderTime,
    'enabled': enabled,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    id: json['id'] as String,
    channelId: json['channelId'] as String,
    title: json['title'] as String,
    startTime: json['startTime'] as int,
    reminderTime: json['reminderTime'] as int,
    enabled: json['enabled'] as bool,
  );
}
```

#### 4.1.6 用户设置模型 (UserSettings)
```dart
// lib/data/models/user_settings_model.dart
enum ThemeMode { system, light, dark }
enum ReminderMethod { notification, inApp, calendar }

class UserSettings {
  final ThemeMode themeMode;
  final String lastChannelId;
  final bool reminderEnabled;
  final List<ReminderMethod> reminderMethods;
  final int reminderMinutesBefore;

  UserSettings({
    this.themeMode = ThemeMode.system,
    this.lastChannelId = 'cctv1',
    this.reminderEnabled = true,
    this.reminderMethods = const [
      ReminderMethod.notification,
      ReminderMethod.inApp,
    ],
    this.reminderMinutesBefore = 5,
  });

  UserSettings copyWith({
    ThemeMode? themeMode,
    String? lastChannelId,
    bool? reminderEnabled,
    List<ReminderMethod>? reminderMethods,
    int? reminderMinutesBefore,
  }) {
    return UserSettings(
      themeMode: themeMode ?? this.themeMode,
      lastChannelId: lastChannelId ?? this.lastChannelId,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMethods: reminderMethods ?? this.reminderMethods,
      reminderMinutesBefore: reminderMinutesBefore ?? this.reminderMinutesBefore,
    );
  }
}
```

#### 4.1.7 缓存模型 (CacheEntry)
```dart
// lib/data/models/cache_entry_model.dart
class CacheEntry {
  final String key;             // 缓存键 (channelId_date)
  final Map<String, dynamic> data;  // 缓存数据
  final int timestamp;          // 缓存时间戳

  CacheEntry({
    required this.key,
    required this.data,
    required this.timestamp,
  });

  bool get isExpired {
    // 缓存7天过期
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(timestamp)
        .add(const Duration(days: 7));
    return DateTime.now().isAfter(expiryDate);
  }
}
```

---

## 5. 服务层设计

### 5.1 网络服务 (ApiService)

```dart
// lib/core/network/api_service.dart
abstract class ApiService {
  Future<Map<String, dynamic>> getEpgInfo({
    required String channelId,
    required String date,
  });
}

class CntvApiService implements ApiService {
  final Dio _dio;

  CntvApiService(this._dio);

  @override
  Future<Map<String, dynamic>> getEpgInfo({
    required String channelId,
    required String date,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.cntv.cn/epg/getEpgInfoByChannelNew',
        queryParameters: {
          'c': channelId,
          'serviceId': 'tvcctv',
          'd': date,
          't': 'jsonp',
          'cb': 'setItem1',
        },
      );
      // 解析JSONP响应
      return _parseJsonpResponse(response.data);
    } on DioException catch (e) {
      throw ApiException(e.message ?? '网络请求失败');
    }
  }

  Map<String, dynamic> _parseJsonpResponse(String response) {
    // 提取JSON部分
    final jsonStr = response.substring(
      response.indexOf('(') + 1,
      response.lastIndexOf(')'),
    );
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  }
}
```

### 5.2 本地存储服务 (StorageService)

```dart
// lib/core/storage/storage_service.dart
abstract class StorageService {
  Future<void> saveFavorites(List<Favorite> favorites);
  Future<List<Favorite>> getFavorites();
  Future<void> saveReminders(List<Reminder> reminders);
  Future<List<Reminder>> getReminders();
  Future<void> saveUserSettings(UserSettings settings);
  Future<UserSettings> getUserSettings();
  Future<void> saveCache(String key, CacheEntry entry);
  Future<CacheEntry?> getCache(String key);
  Future<void> clearCache();
  Future<double> getCacheSize();
}

class HiveStorageService implements StorageService {
  final Box<Map> _favoritesBox;
  final Box<Map> _remindersBox;
  final Box<Map> _settingsBox;
  final Box<Map> _cacheBox;

  HiveStorageService({
    required Box<Map> favoritesBox,
    required Box<Map> remindersBox,
    required Box<Map> settingsBox,
    required Box<Map> cacheBox,
  }) : _favoritesBox = favoritesBox,
       _remindersBox = remindersBox,
       _settingsBox = settingsBox,
       _cacheBox = cacheBox;

  @override
  Future<void> saveFavorites(List<Favorite> favorites) async {
    final data = favorites.map((f) => f.toJson()).toList();
    await _favoritesBox.put('favorites', {'items': data});
  }

  @override
  Future<List<Favorite>> getFavorites() async {
    final data = _favoritesBox.get('favorites');
    if (data == null) return [];
    final items = data['items'] as List;
    return items
        .map((item) => Favorite.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // ... 其他方法实现
}
```

### 5.3 通知服务 (NotificationService)

```dart
// lib/services/notification/notification_service.dart
abstract class NotificationService {
  Future<void> initialize();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
}

class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;

  LocalNotificationService(this._plugin);

  @override
  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      windows: WindowsInitializationSettings(
        appName: 'CCTV节目单',
        appUserModelId: 'com.example.cctv_jmd_flutter',
        guid: 'your-guid-here',
      ),
    );
    await _plugin.initialize(initializationSettings);
  }

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'epg_reminder',
          '节目提醒',
          channelDescription: 'CCTV节目提醒通知',
          importance: Importance.high,
          priority: Priority.high,
        ),
        windows: WindowsNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ... 其他方法实现
}
```

### 5.4 日历服务 (CalendarService)

```dart
// lib/services/calendar/calendar_service.dart
abstract class CalendarService {
  Future<bool> requestPermission();
  Future<String?> createCalendar();
  Future<bool> addEvent({
    required String calendarId,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required String description,
  });
}

class DeviceCalendarService implements CalendarService {
  final DeviceCalendarPlugin _plugin;

  DeviceCalendarService(this._plugin);

  @override
  Future<bool> requestPermission() async {
    final result = await _plugin.requestPermissions();
    return result.isSuccess && result.data == true;
  }

  @override
  Future<String?> createCalendar() async {
    // 创建或获取CCTV节目单日历
    final calendars = await _plugin.retrieveCalendars();
    final existingCalendar = calendars.data?.firstWhere(
      (cal) => cal.name == 'CCTV节目单',
      orElse: () => Calendar(''),
    );
    if (existingCalendar?.id?.isNotEmpty == true) {
      return existingCalendar!.id;
    }
    // 创建新日历
    final result = await _plugin.createCalendar('CCTV节目单');
    return result.data;
  }

  // ... 其他方法实现
}
```

---

## 6. 业务逻辑层设计 (Use Cases)

### 6.1 获取节目单用例 (GetEpgUseCase)

```dart
// lib/domain/usecases/get_epg_usecase.dart
class GetEpgUseCase {
  final EpgRepository _repository;

  GetEpgUseCase(this._repository);

  Future<EpgData> execute({
    required String channelId,
    required DateTime date,
  }) async {
    final dateStr = DateFormat('yyyyMMdd').format(date);
    return await _repository.getEpgData(channelId: channelId, date: dateStr);
  }
}
```

### 6.2 搜索节目用例 (SearchProgramsUseCase)

```dart
// lib/domain/usecases/search_programs_usecase.dart
class SearchProgramsUseCase {
  final EpgRepository _epgRepository;

  SearchProgramsUseCase(this._epgRepository);

  Future<List<SearchResult>> execute({
    required String query,
    required SearchScope scope,
    String? currentChannelId,
  }) async {
    final results = <SearchResult>[];
    
    if (scope == SearchScope.currentChannel && currentChannelId != null) {
      // 搜索当前频道
      final epgData = await _epgRepository.getEpgData(
        channelId: currentChannelId,
        date: DateFormat('yyyyMMdd').format(DateTime.now()),
      );
      results.addAll(_searchInChannel(epgData, query));
    } else {
      // 搜索所有频道
      for (final channel in ChannelConstants.channels) {
        final epgData = await _epgRepository.getEpgData(
          channelId: channel.id,
          date: DateFormat('yyyyMMdd').format(DateTime.now()),
        );
        results.addAll(_searchInChannel(epgData, query));
      }
    }
    
    return results;
  }

  List<SearchResult> _searchInChannel(EpgData epgData, String query) {
    return epgData.programs
        .where((program) => 
            program.title.toLowerCase().contains(query.toLowerCase()))
        .map((program) => SearchResult(
              channelId: epgData.channelId,
              channelName: epgData.channelName,
              program: program,
            ))
        .toList();
  }
}

enum SearchScope { currentChannel, allChannels }

class SearchResult {
  final String channelId;
  final String channelName;
  final Program program;

  SearchResult({
    required this.channelId,
    required this.channelName,
    required this.program,
  });
}
```

### 6.3 管理收藏用例 (ManageFavoritesUseCase)

```dart
// lib/domain/usecases/manage_favorites_usecase.dart
class ManageFavoritesUseCase {
  final FavoritesRepository _repository;

  ManageFavoritesUseCase(this._repository);

  Future<List<Favorite>> getFavorites() async {
    return await _repository.getFavorites();
  }

  Future<void> addFavorite(Favorite favorite) async {
    final favorites = await _repository.getFavorites();
    if (!favorites.any((f) => f.id == favorite.id)) {
      favorites.add(favorite);
      await _repository.saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String id) async {
    final favorites = await _repository.getFavorites();
    favorites.removeWhere((f) => f.id == id);
    await _repository.saveFavorites(favorites);
  }

  Future<bool> isFavorite(String id) async {
    final favorites = await _repository.getFavorites();
    return favorites.any((f) => f.id == id);
  }
}
```

### 6.4 管理提醒用例 (ManageRemindersUseCase)

```dart
// lib/domain/usecases/manage_reminders_usecase.dart
class ManageRemindersUseCase {
  final RemindersRepository _repository;
  final NotificationService _notificationService;
  final CalendarService _calendarService;
  final UserSettingsRepository _settingsRepository;

  ManageRemindersUseCase({
    required RemindersRepository repository,
    required NotificationService notificationService,
    required CalendarService calendarService,
    required UserSettingsRepository settingsRepository,
  }) : _repository = repository,
       _notificationService = notificationService,
       _calendarService = calendarService,
       _settingsRepository = settingsRepository;

  Future<void> addReminder(Reminder reminder) async {
    final settings = await _settingsRepository.getSettings();
    
    // 保存提醒
    final reminders = await _repository.getReminders();
    reminders.add(reminder);
    await _repository.saveReminders(reminders);
    
    // 根据设置执行提醒方式
    if (settings.reminderEnabled) {
      await _scheduleReminder(reminder, settings);
    }
  }

  Future<void> _scheduleReminder(
    Reminder reminder,
    UserSettings settings,
  ) async {
    final reminderDateTime = DateTime.fromMillisecondsSinceEpoch(
      reminder.reminderTime,
    );
    
    if (settings.reminderMethods.contains(ReminderMethod.notification)) {
      await _notificationService.scheduleNotification(
        id: reminder.id.hashCode,
        title: '节目提醒',
        body: '${reminder.title} 即将开始',
        scheduledDate: reminderDateTime,
      );
    }
    
    if (settings.reminderMethods.contains(ReminderMethod.calendar)) {
      final calendarId = await _calendarService.createCalendar();
      if (calendarId != null) {
        await _calendarService.addEvent(
          calendarId: calendarId,
          title: reminder.title,
          startTime: DateTime.fromMillisecondsSinceEpoch(reminder.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(
            reminder.startTime + 3600000, // 默认1小时
          ),
          description: 'CCTV节目提醒',
        );
      }
    }
  }

  // ... 其他方法
}
```

### 6.5 管理设置用例 (ManageSettingsUseCase)

```dart
// lib/domain/usecases/manage_settings_usecase.dart
class ManageSettingsUseCase {
  final UserSettingsRepository _repository;

  ManageSettingsUseCase(this._repository);

  Future<UserSettings> getSettings() async {
    return await _repository.getSettings();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(settings.copyWith(themeMode: mode));
  }

  Future<void> updateLastChannel(String channelId) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(settings.copyWith(lastChannelId: channelId));
  }

  Future<void> updateReminderSettings({
    bool? enabled,
    List<ReminderMethod>? methods,
    int? minutesBefore,
  }) async {
    final settings = await _repository.getSettings();
    await _repository.saveSettings(settings.copyWith(
      reminderEnabled: enabled,
      reminderMethods: methods,
      reminderMinutesBefore: minutesBefore,
    ));
  }
}
```

---

## 7. UI层设计

### 7.1 页面结构

#### 7.1.1 主页面 (HomePage)
```dart
// lib/presentation/pages/home_page.dart
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChannel = ref.watch(currentChannelProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final epgDataAsync = ref.watch(epgDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentChannel?.name ?? 'CCTV节目单'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      drawer: const ChannelDrawer(),
      body: Column(
        children: [
          DatePickerWidget(
            selectedDate: selectedDate,
            onDateSelected: (date) {
              ref.read(selectedDateProvider.notifier).state = date;
            },
          ),
          Expanded(
            child: epgDataAsync.when(
              data: (epgData) => ProgramListWidget(
                programs: epgData.programs,
                onFavorite: (program) => _toggleFavorite(ref, program),
                onReminder: (program) => _setReminder(ref, program),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => ErrorWidget(
                message: error.toString(),
                onRetry: () => ref.invalidate(epgDataProvider),
              ),
            ),
          ),
          LiveEntryWidget(
            liveUrl: epgDataAsync.valueOrNull?.liveUrl,
          ),
        ],
      ),
    );
  }
}
```

#### 7.1.2 频道侧边栏 (ChannelDrawer)
```dart
// lib/presentation/widgets/channel_drawer.dart
class ChannelDrawer extends ConsumerWidget {
  const ChannelDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChannel = ref.watch(currentChannelProvider);

    return Drawer(
      child: ListView.builder(
        itemCount: ChannelConstants.channels.length,
        itemBuilder: (context, index) {
          final channel = ChannelConstants.channels[index];
          return ListTile(
            title: Text(channel.name),
            selected: channel.id == currentChannel?.id,
            onTap: () {
              ref.read(currentChannelProvider.notifier).state = channel;
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
```

#### 7.1.3 搜索页面 (SearchPage)
```dart
// lib/presentation/pages/search_page.dart
class SearchPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  SearchScope _scope = SearchScope.currentChannel;

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: '搜索节目...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) => _performSearch(ref, query),
        ),
        actions: [
          DropdownButton<SearchScope>(
            value: _scope,
            items: const [
              DropdownMenuItem(
                value: SearchScope.currentChannel,
                child: Text('当前频道'),
              ),
              DropdownMenuItem(
                value: SearchScope.allChannels,
                child: Text('所有频道'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _scope = value);
                _performSearch(ref, _searchController.text);
              }
            },
          ),
        ],
      ),
      body: searchResults.when(
        data: (results) => ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return SearchResultTile(
              result: result,
              onTap: () => _navigateToProgram(result),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('搜索失败: $error')),
      ),
    );
  }

  void _performSearch(WidgetRef ref, String query) {
    if (query.isNotEmpty) {
      ref.read(searchQueryProvider.notifier).state = query;
      ref.read(searchScopeProvider.notifier).state = _scope;
    }
  }
}
```

#### 7.1.4 收藏页面 (FavoritesPage)
```dart
// lib/presentation/pages/favorites_page.dart
class FavoritesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text('暂无收藏'),
            );
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return FavoriteTile(
                favorite: favorite,
                onDelete: () => _deleteFavorite(ref, favorite.id),
                onTap: () => _navigateToProgram(favorite),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}
```

#### 7.1.5 设置页面 (SettingsPage)
```dart
// lib/presentation/pages/settings_page.dart
class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          _buildThemeSection(settings, ref),
          _buildReminderSection(settings, ref),
          _buildCacheSection(ref),
        ],
      ),
    );
  }

  Widget _buildThemeSection(UserSettings settings, WidgetRef ref) {
    return ListTile(
      title: const Text('主题模式'),
      subtitle: Text(_getThemeModeName(settings.themeMode)),
      onTap: () => _showThemeDialog(settings, ref),
    );
  }

  Widget _buildReminderSection(UserSettings settings, WidgetRef ref) {
    return ExpansionTile(
      title: const Text('提醒设置'),
      children: [
        SwitchListTile(
          title: const Text('启用提醒'),
          value: settings.reminderEnabled,
          onChanged: (value) {
            ref.read(manageSettingsUseCaseProvider)
                .updateReminderSettings(enabled: value);
          },
        ),
        // ... 其他提醒设置
      ],
    );
  }

  Widget _buildCacheSection(WidgetRef ref) {
    final cacheSize = ref.watch(cacheSizeProvider);
    return ListTile(
      title: const Text('清除缓存'),
      subtitle: Text('当前缓存: ${cacheSize.valueOrNull ?? 0} MB'),
      onTap: () => _clearCache(ref),
    );
  }
}
```

### 7.2 Providers设计

```dart
// lib/presentation/providers/providers.dart

// 核心Providers
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return CntvApiService(ref.read(dioProvider));
});

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('需要在main.dart中初始化');
});

// 仓库Providers
final epgRepositoryProvider = Provider<EpgRepository>((ref) {
  return EpgRepositoryImpl(
    apiService: ref.read(apiServiceProvider),
    storageService: ref.read(storageServiceProvider),
  );
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(
    storageService: ref.read(storageServiceProvider),
  );
});

// 用例Providers
final getEpgUseCaseProvider = Provider<GetEpgUseCase>((ref) {
  return GetEpgUseCase(ref.read(epgRepositoryProvider));
});

final searchProgramsUseCaseProvider = Provider<SearchProgramsUseCase>((ref) {
  return SearchProgramsUseCase(ref.read(epgRepositoryProvider));
});

// 状态Providers
final currentChannelProvider = StateProvider<Channel?>((ref) {
  return null; // 将在初始化时设置
});

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final epgDataProvider = FutureProvider<EpgData>((ref) async {
  final channel = ref.watch(currentChannelProvider);
  final date = ref.watch(selectedDateProvider);
  if (channel == null) throw Exception('未选择频道');
  return ref.read(getEpgUseCaseProvider).execute(
    channelId: channel.id,
    date: date,
  );
});
```

---

## 8. 工具模块设计

### 8.1 常量定义

```dart
// lib/core/constants/channel_constants.dart
class ChannelConstants {
  static const List<Channel> channels = [
    Channel(id: 'cctv1', name: 'CCTV-1 综合'),
    Channel(id: 'cctv2', name: 'CCTV-2 财经'),
    Channel(id: 'cctv3', name: 'CCTV-3 综艺'),
    Channel(id: 'cctv4', name: 'CCTV-4 中文国际'),
    Channel(id: 'cctv5', name: 'CCTV-5 体育'),
    Channel(id: 'cctv5+', name: 'CCTV-5+ 体育赛事'),
    Channel(id: 'cctv6', name: 'CCTV-6 电影'),
    Channel(id: 'cctv7', name: 'CCTV-7 国防军事'),
    Channel(id: 'cctv8', name: 'CCTV-8 电视剧'),
    Channel(id: 'cctvjilu', name: 'CCTV-9 纪录'),
    Channel(id: 'cctv10', name: 'CCTV-10 科教'),
    Channel(id: 'cctv11', name: 'CCTV-11 戏曲'),
    Channel(id: 'cctv12', name: 'CCTV-12 社会与法'),
    Channel(id: 'cctv13', name: 'CCTV-13 新闻'),
    Channel(id: 'cctvchild', name: 'CCTV-14 少儿'),
    Channel(id: 'cctv15', name: 'CCTV-15 音乐'),
    Channel(id: 'cctv16', name: 'CCTV-16 奥林匹克'),
    Channel(id: 'cctv17', name: 'CCTV-17 农业农村'),
  ];
}
```

### 8.2 错误处理

```dart
// lib/core/errors/exceptions.dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}
```

### 8.3 工具类

```dart
// lib/core/utils/date_utils.dart
class AppDateUtils {
  static String formatToApiDate(DateTime date) {
    return DateFormat('yyyyMMdd').format(date);
  }

  static String formatToDisplayDate(DateTime date) {
    return DateFormat('yyyy年MM月dd日').format(date);
  }

  static String formatToTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  static bool isCurrentProgram(int startTime, int endTime) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return now >= startTime && now < endTime;
  }
}
```

---

## 9. 单元测试策略

### 9.1 测试原则
- **独立性**：每个测试独立运行，不依赖其他测试
- **可重复性**：测试结果可重复
- **快速性**：单元测试应快速执行
- **隔离性**：使用Mock隔离外部依赖

### 9.2 测试目录结构
```
test/
├── unit/
│   ├── data/
│   │   ├── models/          # 数据模型测试
│   │   ├── repositories/    # 仓库实现测试
│   │   └── datasources/     # 数据源测试
│   ├── domain/
│   │   └── usecases/        # 用例测试
│   └── services/            # 服务测试
├── widget/                   # Widget测试
├── integration/              # 集成测试
└── mocks/                    # Mock类
```

### 9.3 测试示例

#### 9.3.1 数据模型测试
```dart
// test/unit/data/models/program_model_test.dart
void main() {
  group('Program Model', () {
    test('should create Program from JSON', () {
      // Arrange
      final json = {
        'title': '早间新闻',
        'startTime': 1780763470,
        'endTime': 1780766170,
        'showTime': '00:31',
        'length': 2700,
      };

      // Act
      final program = Program.fromJson(json);

      // Assert
      expect(program.title, '早间新闻');
      expect(program.startTime, 1780763470);
      expect(program.length, 2700);
    });

    test('should convert Program to JSON', () {
      // Arrange
      final program = Program(
        title: '早间新闻',
        startTime: 1780763470,
        endTime: 1780766170,
        showTime: '00:31',
        length: 2700,
      );

      // Act
      final json = program.toJson();

      // Assert
      expect(json['title'], '早间新闻');
      expect(json['startTime'], 1780763470);
    });
  });
}
```

#### 9.3.2 用例测试
```dart
// test/unit/domain/usecases/get_epg_usecase_test.dart
class MockEpgRepository extends Mock implements EpgRepository {}

void main() {
  late GetEpgUseCase useCase;
  late MockEpgRepository mockRepository;

  setUp(() {
    mockRepository = MockEpgRepository();
    useCase = GetEpgUseCase(mockRepository);
  });

  group('GetEpgUseCase', () {
    test('should get epg data from repository', () async {
      // Arrange
      final expectedEpgData = EpgData(
        channelId: 'cctv1',
        channelName: 'CCTV-1 综合',
        date: '20260607',
        programs: [],
      );
      when(() => mockRepository.getEpgData(
        channelId: 'cctv1',
        date: '20260607',
      )).thenAnswer((_) async => expectedEpgData);

      // Act
      final result = await useCase.execute(
        channelId: 'cctv1',
        date: DateTime(2026, 6, 7),
      );

      // Assert
      expect(result, expectedEpgData);
      verify(() => mockRepository.getEpgData(
        channelId: 'cctv1',
        date: '20260607',
      )).called(1);
    });
  });
}
```

#### 9.3.3 Provider测试
```dart
// test/unit/presentation/providers/epg_provider_test.dart
void main() {
  group('EpgDataProvider', () {
    test('should update when channel changes', () async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          getEpgUseCaseProvider.overrideWithValue(mockGetEpgUseCase),
        ],
      );
      addTearDown(container.dispose);

      // Act
      container.read(currentChannelProvider.notifier).state = 
          Channel(id: 'cctv2', name: 'CCTV-2 财经');

      // Assert
      final epgData = await container.read(epgDataProvider.future);
      expect(epgData.channelId, 'cctv2');
    });
  });
}
```

### 9.4 Mock类定义
```dart
// test/mocks/mocks.dart
class MockApiService extends Mock implements ApiService {}
class MockStorageService extends Mock implements StorageService {}
class MockNotificationService extends Mock implements NotificationService {}
class MockCalendarService extends Mock implements CalendarService {}
```

---

## 10. 依赖关系图

### 10.1 模块依赖矩阵
| 模块 | 依赖模块 | 被依赖模块 |
|------|----------|------------|
| UI层 | Domain层, Core层 | - |
| Domain层 | Data层 | UI层 |
| Data层 | Core层 | Domain层 |
| Core层 | - | Data层, Domain层, UI层 |

### 10.2 包依赖
```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  dio: ^5.4.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_local_notifications: ^16.3.0
  device_calendar: ^4.3.2
  go_router: ^12.1.3
  intl: ^0.19.0
  path_provider: ^2.1.1
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.1
  riverpod_test: ^0.1.3
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
  json_serializable: ^6.7.1
```

---

## 11. 性能优化策略

### 11.1 数据缓存
- 使用内存缓存（Map）存储当前频道数据
- 使用Hive持久化缓存最近7天数据
- 实现LRU缓存策略，自动清理过期数据

### 11.2 网络优化
- 使用Dio拦截器实现请求取消
- 实现请求重试机制（指数退避）
- 使用连接池复用HTTP连接

### 11.3 UI优化
- 使用ListView.builder实现懒加载
- 实现节目列表项复用
- 使用const构造函数减少重建

---

## 12. 安全考虑

### 12.1 数据安全
- 本地存储数据不包含敏感信息
- API请求使用HTTPS
- 缓存数据设置过期时间

### 12.2 权限管理
- 通知权限：运行时请求
- 日历权限：运行时请求
- 网络权限：AndroidManifest.xml声明

---

## 13. 部署与发布

### 13.1 构建配置
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# Windows
flutter build windows --release

# Web
flutter build web --release
```

### 13.2 版本管理
- 使用语义化版本号（Semantic Versioning）
- 主版本号：不兼容的API修改
- 次版本号：向下兼容的功能性新增
- 修订号：向下兼容的问题修正

---

## 14. 附录

### 14.1 参考资源
- [Flutter官方文档](https://flutter.dev/docs)
- [Riverpod文档](https://riverpod.dev/)
- [Dio文档](https://pub.dev/packages/dio)
- [Hive文档](https://docs.hivedb.dev/)

### 14.2 相关文档
- 需求文档：`doc/proposal.md`
- API文档：`doc/api.md`
- 用户手册：`doc/user-manual.md`
