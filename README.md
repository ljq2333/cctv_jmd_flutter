# CCTV节目单查询软件 📺

> 基于 Flutter 的跨平台 CCTV 节目单查询应用，支持 Android、Windows、Web 平台。

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.11-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20|%20Windows%20|%20Web-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## ✨ 功能特性

### 📋 节目单查看
- 支持 CCTV-1 至 CCTV-17 全频道节目单查询
- 显示节目名称、播出时间、时长等信息
- 支持查看历史节目单（前一个月）和未来节目单（后两天）
- 高亮标记当前正在播出的节目

### 🔄 频道切换
- 侧边栏展示完整频道列表
- 滑动即可切换频道
- 自动记忆用户最后选择的频道

### 🔍 节目搜索
- 按节目名称快速搜索
- 支持限定范围：当前频道 / 所有频道
- 清晰展示搜索结果中的频道、时间、节目名称

### ⭐ 节目收藏
- 一键收藏喜爱的节目
- 收藏列表管理（查看 / 删除）
- 数据本地持久化存储

### ⏰ 节目提醒
- 为指定节目设置观看提醒
- 多种提醒方式：
  - 系统推送通知
  - 应用内提醒
  - 写入系统日历
- 提醒时间可自定义（默认节目前 5 分钟）

### 📺 直播入口
- 提供 CCTV 各频道官方直播链接
- 一键跳转至 CCTV 官方直播页面

### 🌙 多主题支持
- 浅色模式 / 深色模式
- 跟随系统设置
- 支持手动切换

### 📡 离线支持
- 自动缓存已查询的节目单
- 无网络时仍可查看缓存数据
- 联网后自动同步最新数据

---

## 🏗️ 技术架构

### 技术栈

| 层级 | 技术 | 说明 |
|------|------|------|
| **框架** | Flutter 3.x + Dart 3.11 | 跨平台 UI 框架 |
| **状态管理** | Riverpod | 依赖注入 + 状态管理 |
| **网络请求** | Dio 5.7 | HTTP 客户端，支持拦截器 |
| **本地存储** | Hive 2.2 | 高性能键值对存储 |
| **路由管理** | 原生 Navigator | 声明式页面路由 |
| **日历集成** | device_calendar | 系统日历读写 |
| **通知服务** | flutter_local_notifications | 本地推送通知 |

### 架构设计

采用 **Clean Architecture** 分层架构，遵循"高内聚、低耦合"原则：

```
┌─────────────────────────────────────┐
│      Presentation Layer (UI)        │
│  Pages · Widgets · Providers        │
├─────────────────────────────────────┤
│       Domain Layer (业务逻辑)        │
│  Use Cases · Repository Interfaces  │
├─────────────────────────────────────┤
│        Data Layer (数据层)           │
│  Repositories · DataSources · Models│
├─────────────────────────────────────┤
│     Core Layer (核心基础设施)         │
│  Network · Storage · Utils · Errors  │
└─────────────────────────────────────┘
```

---

## 📁 项目结构

```
lib/
├── main.dart                     # 应用入口
├── core/                         # 核心基础设施
│   ├── constants/                # 常量定义
│   │   ├── api_constants.dart    # API 相关常量
│   │   ├── app_constants.dart    # 应用常量
│   │   ├── channel_constants.dart# 频道列表
│   │   └── storage_constants.dart# 存储常量
│   ├── errors/                   # 错误处理
│   │   ├── exceptions.dart       # 异常定义
│   │   ├── failures.dart         # 失败类型
│   │   └── error_handler.dart    # 错误处理器
│   ├── network/                  # 网络层
│   │   ├── dio_client.dart       # Dio 客户端封装
│   │   ├── api_service.dart      # API 服务抽象
│   │   ├── cntv_api_service.dart # CCTV API 实现
│   │   └── network_info.dart     # 网络状态检测
│   ├── storage/                  # 存储层
│   │   ├── storage_service.dart  # 存储抽象
│   │   ├── hive_storage_service.dart # Hive 实现
│   │   └── hive_initializer.dart # Hive 初始化
│   └── utils/                    # 工具类
│       ├── date_utils.dart       # 日期工具
│       ├── format_utils.dart     # 格式化工具
│       ├── platform_utils.dart   # 平台工具
│       └── validator_utils.dart  # 验证工具
├── data/                         # 数据层
│   ├── models/                   # 数据模型
│   │   ├── program_model.dart    # 节目模型
│   │   ├── channel_model.dart    # 频道模型
│   │   ├── epg_data_model.dart   # 节目单数据模型
│   │   ├── favorite_model.dart   # 收藏模型
│   │   ├── reminder_model.dart   # 提醒模型
│   │   ├── search_result_model.dart # 搜索结果模型
│   │   ├── cache_entry_model.dart# 缓存条目模型
│   │   └── user_settings_model.dart # 用户设置模型
│   ├── datasources/              # 数据源
│   │   ├── remote_data_source.dart       # 远程数据源抽象
│   │   ├── remote_data_source_impl.dart  # 远程数据源实现
│   │   ├── local_data_source.dart        # 本地数据源抽象
│   │   ├── local_data_source_impl.dart   # 本地数据源实现
│   │   └── cache_data_source.dart        # 缓存数据源
│   └── repositories/             # 仓库实现
│       ├── epg_repository_impl.dart
│       ├── favorites_repository_impl.dart
│       ├── reminders_repository_impl.dart
│       └── user_settings_repository_impl.dart
├── domain/                       # 领域层
│   ├── repositories/             # 仓库接口
│   │   ├── epg_repository.dart
│   │   ├── favorites_repository.dart
│   │   ├── reminders_repository.dart
│   │   └── user_settings_repository.dart
│   └── usecases/                 # 用例
│       ├── get_epg_usecase.dart
│       ├── search_programs_usecase.dart
│       ├── manage_favorites_usecase.dart
│       ├── manage_reminders_usecase.dart
│       └── manage_settings_usecase.dart
├── presentation/                 # 表现层
│   ├── pages/                    # 页面
│   │   ├── home_page.dart        # 主页
│   │   ├── schedule_page.dart    # 日程页
│   │   ├── search_page.dart      # 搜索页
│   │   ├── favorites_page.dart   # 收藏页
│   │   ├── settings_page.dart    # 设置页
│   │   └── profile_page.dart     # 个人页
│   ├── widgets/                  # 可复用组件
│   │   ├── channel_drawer.dart   # 频道侧边栏
│   │   ├── date_picker_widget.dart# 日期选择器
│   │   ├── program_list_widget.dart# 节目列表
│   │   ├── loading_widget.dart   # 加载中
│   │   └── error_widget.dart     # 错误提示
│   └── providers/                # Riverpod Providers
│       ├── core_providers.dart
│       ├── data_providers.dart
│       ├── repository_providers.dart
│       ├── state_providers.dart
│       └── usecase_providers.dart
└── services/                     # 服务层
    ├── cache/                    # 缓存服务
    │   ├── cache_service.dart
    │   ├── cache_service_impl.dart
    │   ├── cache_key_generator.dart
    │   └── cache_cleanup_strategy.dart
    ├── notification/             # 通知服务
    │   ├── notification_service.dart
    │   ├── local_notification_service.dart
    │   ├── notification_permission.dart
    │   └── in_app_reminder_service.dart
    └── calendar/                 # 日历服务
        ├── calendar_service.dart
        ├── device_calendar_service.dart
        ├── calendar_permission.dart
        └── calendar_event_formatter.dart
```

---

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.x
- Dart SDK >= 3.11
- 支持 Android、Windows、Web 开发环境

### 安装与运行

```bash
# 1. 克隆项目
git clone <项目地址>
cd cctv_jmd_flutter

# 2. 安装依赖
flutter pub get

# 3. 运行应用
flutter run           # 默认设备
flutter run -d android  # Android
flutter run -d windows  # Windows
flutter run -d chrome   # Web

# 4. 构建发布版本
flutter build apk       # Android APK
flutter build windows   # Windows 安装包
flutter build web       # Web 部署
```

### 代码质量检查

```bash
# 代码分析
flutter analyze

# 运行测试
flutter test

# 代码格式化
dart format --set-exit-if-changed .
```

---

## 📡 API 接口

本应用使用 CCTV 官方公开的节目单 API：

```
GET https://api.cntv.cn/epg/getEpgInfoByChannelNew
```

| 参数 | 类型 | 说明 | 示例 |
|------|------|------|------|
| `c` | string | 频道 ID | cctv1 |
| `serviceId` | string | 服务 ID | tvcctv |
| `d` | string | 日期 (yyyyMMdd) | 20260607 |
| `t` | string | 返回格式 | jsonp |
| `cb` | string | 回调函数名 | setItem1 |

### 支持的频道

| 频道 ID | 频道名称 |
|---------|---------|
| cctv1 | CCTV-1 综合 |
| cctv2 | CCTV-2 财经 |
| cctv3 | CCTV-3 综艺 |
| cctv4 | CCTV-4 中文国际 |
| cctv5 | CCTV-5 体育 |
| cctv5+ | CCTV-5+ 体育赛事 |
| cctv6 | CCTV-6 电影 |
| cctv7 | CCTV-7 国防军事 |
| cctv8 | CCTV-8 电视剧 |
| cctvjilu | CCTV-9 纪录 |
| cctv10 | CCTV-10 科教 |
| cctv11 | CCTV-11 戏曲 |
| cctv12 | CCTV-12 社会与法 |
| cctv13 | CCTV-13 新闻 |
| cctvchild | CCTV-14 少儿 |
| cctv15 | CCTV-15 音乐 |
| cctv16 | CCTV-16 奥林匹克 |
| cctv17 | CCTV-17 农业农村 |

---

## 🧪 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/unit/core/network/cntv_api_service_test.dart

# 查看测试覆盖率（需安装 lcov）
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 测试覆盖范围

| 模块 | 覆盖内容 |
|------|---------|
| **Core** | 常量、错误处理、网络层、存储层、工具类 |
| **Data** | 数据模型序列化、数据源、仓库实现 |
| **Domain** | 仓库接口、用例逻辑 |
| **Presentation** | Providers、Widgets、Pages |
| **Services** | 缓存服务、日历服务、通知服务 |

---

## 📚 文档索引

| 文档 | 说明 |
|------|------|
| [需求文档](doc/proposal.md) | 产品需求与功能规格 |
| [概要设计](doc/high-level-design.md) | 系统架构概览 |
| [详细设计](doc/detailed-design.md) | 模块详细设计 |
| [Figma 设计规范](doc/figma-design.md) | UI 设计规范 |
| [项目进度](doc/tasks/progress.md) | 开发进度跟踪 |

---

## 🛠️ 技术栈详解

### 状态管理 — Riverpod

使用 `flutter_riverpod` + `riverpod_annotation` 实现：

- **依赖注入**：所有 Service、Repository、UseCase 通过 Provider 注入
- **状态管理**：页面状态通过 `StateNotifierProvider` / `AsyncNotifierProvider` 管理
- **自动释放**：不再使用的状态自动清理

### 网络请求 — Dio

- 统一拦截器处理错误和日志
- 连接超时和响应超时控制
- JSONP 响应解析适配

### 本地存储 — Hive

- 高性能键值对存储
- 支持自定义对象序列化
- 缓存数据自动过期清理（7 天）

---

## 🤝 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'feat: add some feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

---

## 📄 许可证

本项目基于 MIT 许可证开源 — 详见 LICENSE 文件。
