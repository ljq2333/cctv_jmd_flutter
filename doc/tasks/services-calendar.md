# Services - Calendar 模块任务

## 模块说明
实现日历服务，支持将节目提醒写入系统日历。

---

## 任务清单

### 1. 日历服务接口
- [x] 创建 `lib/services/calendar/calendar_service.dart` 文件
- [x] 定义 `CalendarService` 抽象类
- [x] 定义 `requestPermission` 方法签名
- [x] 定义 `hasPermission` 方法签名
- [x] 定义 `createCalendar` 方法签名
- [x] 定义 `addEvent` 方法签名

### 2. 设备日历服务实现
- [x] 创建 `lib/services/calendar/device_calendar_service.dart` 文件
- [x] 实现 `DeviceCalendarService` 类
- [x] 实现日历权限请求
- [x] 实现日历权限检查
- [x] 实现日历创建/获取
- [x] 实现事件添加
- [x] 处理日历操作错误

### 3. 日历权限处理
- [x] 创建 `lib/services/calendar/calendar_permission.dart` 文件
- [x] 实现权限请求
- [x] 实现权限状态检查
- [x] 处理权限拒绝情况

### 4. 日历事件格式化
- [x] 创建 `lib/services/calendar/calendar_event_formatter.dart` 文件
- [x] 实现事件标题格式化
- [x] 实现事件时间格式化
- [x] 实现事件描述格式化

### 5. 服务测试
- [x] 创建日历服务测试文件
- [x] 测试权限请求
- [x] 测试日历创建
- [x] 测试事件添加
- [x] 测试错误处理

### 6. 集成到日程页面
- [x] 在 SchedulePage 中添加"添加到日历"功能
- [x] 使用 calendarServiceProvider 进行集成

---

## 验收标准
- [x] 日历服务接口和实现类创建完成
- [x] 日历权限请求正常
- [x] 日历创建正常
- [x] 事件添加正常
- [x] 错误处理正确
- [x] 测试通过
- [x] 已集成到日程页面