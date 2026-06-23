# Presentation - Pages 模块任务

## 模块说明
实现所有页面，包括主页、搜索页、收藏页、设置页。

---

## 任务清单

### 1. 主页面 (HomePage)
- [x] 创建 `lib/presentation/pages/home_page.dart` 文件
- [x] 实现 `HomePage` 类（ConsumerStatefulWidget）
- [x] 实现AppBar（标题、搜索按钮、刷新按钮）
- [x] 集成日期选择器
- [x] 集成节目列表
- [x] 集成直播入口
- [x] 集成频道侧边栏（右滑打开）
- [x] 支持下拉刷新
- [x] 支持点击提醒按钮添加日程
- [x] 处理加载状态
- [x] 处理错误状态
- [x] 添加Widget测试

### 2. 搜索页面 (SearchPage)
- [x] 创建 `lib/presentation/pages/search_page.dart` 文件
- [x] 实现 `SearchPage` 类（ConsumerStatefulWidget）
- [x] 实现搜索输入框
- [x] 实现搜索范围选择（当前频道/所有频道）
- [x] 实现搜索结果列表
- [x] 实现搜索结果点击跳转
- [x] 处理空结果状态
- [x] 处理加载状态
- [x] 添加Widget测试

### 3. 收藏页面 (FavoritesPage)
- [x] 创建 `lib/presentation/pages/favorites_page.dart` 文件
- [x] 实现 `FavoritesPage` 类（ConsumerWidget）
- [x] 实现收藏列表
- [x] 实现收藏项显示（频道、时间、节目名）
- [x] 实现删除收藏功能
- [x] 实现点击跳转功能
- [x] 处理空收藏状态
- [x] 处理加载状态
- [x] 添加Widget测试

### 4. 设置页面 (SettingsPage)
- [x] 创建 `lib/presentation/pages/settings_page.dart` 文件
- [x] 实现 `SettingsPage` 类（ConsumerWidget）
- [x] 实现主题模式设置
- [x] 实现提醒设置
- [x] 实现缓存管理
- [x] 实现清除缓存功能
- [x] 添加Widget测试

### 5. 日程页面 (SchedulePage)
- [x] 创建 `lib/presentation/pages/schedule_page.dart` 文件
- [x] 实现 `SchedulePage` 类（ConsumerWidget）
- [x] 显示已订阅的节目提醒列表
- [x] 按时间排序显示
- [x] 支持左滑删除日程
- [x] 支持开关启用/禁用提醒
- [x] 支持长按修改日程（标题、提醒时间）
- [x] 支持添加到系统日历功能
- [x] 处理空日程状态
- [x] 处理加载状态

### 6. 我的页面 (ProfilePage)
- [x] 创建 `lib/presentation/pages/profile_page.dart` 文件
- [x] 实现 `ProfilePage` 类（ConsumerWidget）
- [x] 集成我的收藏功能
- [x] 集成设置功能（主题、提醒、缓存、关于）
- [x] 支持删除收藏
- [x] 支持修改设置

### 7. 底部导航主框架
- [x] 修改 `lib/main.dart`
- [x] 实现 `MainScreen` 类（带底部导航）
- [x] 配置三个Tab：节目、日程、我的
- [x] 使用 NavigationBar 组件

### 8. 路由配置
- [x] 创建 `lib/presentation/routes/app_router.dart` 文件
- [x] 定义所有路由路径
- [x] 实现路由跳转

---

## 验收标准
- [x] 所有页面创建完成
- [x] 页面能正确显示数据
- [x] 用户交互正常
- [x] 状态管理正确
- [x] Widget测试通过