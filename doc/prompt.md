# Vibe Coding 终极起始 Prompt

## 项目全景

你正在开发一个 **CCTV节目单查询软件**（`cctv_jmd_flutter`），基于 Flutter 的跨平台应用，支持 Android、Windows、Web。

**核心功能**：查看CCTV全频道节目单、搜索节目、收藏节目、节目提醒、直播入口。

**技术架构**：Clean Architecture + Riverpod + Dio + Hive + flutter_local_notifications + device_calendar + go_router

**文档索引**：
- 需求文档：`doc/proposal.md`
- 详细设计：`doc/detailed-design.md`
- 任务分解：`doc/tasks/progress.md`（总控）及 `doc/tasks/*.md`（各模块任务）

---

## 架构与权限设计

### 主 Agent（Orchestrator）

**唯一拥有全局视野**，职责严格限定为：

1. **读取进度**：读取 `doc/tasks/progress.md` 跟踪整体进度
2. **指派任务**：根据进度表，派生子 Agent 执行下一个待完成模块
3. **执行 Git Commit**：模块完成后执行原子化存档

**权限边界**：
- ✅ 可读取：`doc/tasks/progress.md`、所有 `doc/tasks/*.md`
- ✅ 可执行：`git add .`、`git commit`
- ❌ 禁止：直接编写业务代码、直接修改 `lib/` 或 `test/` 目录

### 子 Agent（Worker）

由主 Agent 派生，**严格物理隔离**：

**权限边界**：
- ✅ 可读写：当前目标模块对应的 `lib/` 文件及 `test/` 文件
- ✅ 可读取：当前模块的 `doc/tasks/<module-name>.md` 任务清单
- ❌ 禁止：篡改其他模块代码、修改 `doc/tasks/progress.md`、执行 git 操作

**隔离规则**：
- 每个子 Agent 仅处理一个模块
- 子 Agent 完成后必须返回结果给主 Agent
- 子 Agent 之间无直接通信

---

## 测试驱动开发 (TDD) 约束

子 Agent 在编写业务代码前，**必须**遵循红-绿-重构循环：

### 1. 红灯阶段（Red）
- 先编写预期会 **Fail** 的单元测试
- 测试必须覆盖模块的核心功能点
- 运行测试确认失败（`flutter test`）

### 2. 绿灯阶段（Green）
- 编写最小化实现代码使测试变绿
- 运行测试确认全部通过

### 3. 重构阶段（Refactor）
- 优化代码结构，保持测试通过
- 确保代码符合 Clean Architecture 分层规范

### TDD 检查点
```
每个任务完成后必须验证：
□ 测试文件已创建
□ 测试覆盖核心功能
□ flutter test 全部通过
```

---

## 质量红线与防暴走熔断

### 质量工具链

代码必须通过以下检查：

| 工具 | 命令 | 要求 |
|------|------|------|
| Flutter Analyze | `flutter analyze` | 无 Error、无 Warning |
| Dart Format | `dart format --set-exit-if-changed .` | 格式一致 |
| Flutter Test | `flutter test` | 100% 通过 |

### 防暴走熔断机制

**连续失败计数器**：子 Agent 每次质量检查失败，计数器 +1

**熔断触发条件**：连续 3 次重构仍无法通过质量工具链检查

**熔断行为**：
1. 立即挂起当前模块
2. 停止生成任何代码
3. 向用户输出错误日志：
   ```
   ⚠️ 模块熔断：[模块名称]
   失败次数：3
   最后一次错误：[错误详情]
   建议：请人工介入检查模块设计或依赖问题
   ```

**重置条件**：人工介入修复后，计数器重置为 0

---

## 原子化存档

### 存档触发条件

当一个模块的所有任务完成且测试通过后，主 Agent 必须执行：

### 存档流程

1. **更新进度表**：在 `doc/tasks/progress.md` 中将对应模块的 `[ ]` 改为 `[x]`

2. **执行 Git Commit**：
   ```bash
   git add .
   git commit -m "feat(模块名): 自动化实现并测试通过"
   ```

3. **Commit 命名规范**：
   - 新功能：`feat(模块名): 描述`
   - 修复：`fix(模块名): 描述`
   - 重构：`refactor(模块名): 描述`

### 存档示例

```bash
# 模块完成后
git add .
git commit -m "feat(core-network): 实现Dio客户端和CNTV API服务"
```

---

## 执行流程

### 主 Agent 工作流

```
┌─────────────────────────────────────────────────────────────┐
│  1. 读取 doc/tasks/progress.md                              │
│  2. 找到下一个未完成的模块 [ ]                                │
│  3. 派生子 Agent，传入模块任务文件路径                         │
│  4. 等待子 Agent 返回结果                                    │
│  5. 如果成功：                                               │
│     - 更新 progress.md 打钩 [x]                              │
│     - 执行 git commit                                        │
│  6. 如果失败（熔断）：                                        │
│     - 输出错误日志                                            │
│     - 等待人工介入                                            │
│  7. 回到步骤 1，继续下一个模块                                │
└─────────────────────────────────────────────────────────────┘
```

### 子 Agent 工作流

```
┌─────────────────────────────────────────────────────────────┐
│  1. 读取 doc/tasks/<module-name>.md 任务清单                  │
│  2. 对每个任务执行 TDD 循环：                                  │
│     a. 编写测试 → 确认失败（红）                              │
│     b. 编写实现 → 确认通过（绿）                              │
│     c. 重构代码 → 保持通过                                    │
│  3. 运行质量工具链检查                                        │
│  4. 如果通过：返回成功                                        │
│  5. 如果失败：重试（最多 3 次）                                │
│  6. 如果连续 3 次失败：返回熔断错误                           │
└─────────────────────────────────────────────────────────────┘
```

---

## 模块执行顺序

根据依赖关系，按以下顺序执行：

### Phase 1: 基础设施（Core层）
1. `core-constants` - 常量定义
2. `core-errors` - 错误处理
3. `core-utils` - 工具类
4. `core-storage` - 存储层
5. `core-network` - 网络层

### Phase 2: 数据层（Data层）
1. `data-models` - 数据模型
2. `domain-repositories` - 仓库接口
3. `data-datasources` - 数据源
4. `data-repositories` - 仓库实现

### Phase 3: 领域层（Domain层）
1. `domain-usecases` - 用例

### Phase 4: 服务层（Services层）
1. `services-cache` - 缓存服务
2. `services-notification` - 通知服务
3. `services-calendar` - 日历服务

### Phase 5: 表现层（Presentation层）
1. `presentation-providers` - Providers
2. `presentation-widgets` - 组件
3. `presentation-pages` - 页面

---

## 快速启动

**主 Agent 启动命令**：

```
请按照 doc/prompt.md 的规范开始执行项目开发。
从 doc/tasks/progress.md 读取进度，派生子 Agent 执行第一个未完成模块。
```

---

## 附录：文件结构

```
cctv_jmd_flutter/
├── doc/
│   ├── proposal.md              # 需求文档
│   ├── detailed-design.md       # 详细设计
│   ├── prompt.md                # 本文件
│   └── tasks/
│       ├── progress.md          # 总控进度
│       ├── core-constants.md    # 常量模块任务
│       ├── core-errors.md       # 错误模块任务
│       ├── core-network.md      # 网络模块任务
│       ├── core-storage.md      # 存储模块任务
│       ├── core-utils.md        # 工具模块任务
│       ├── data-models.md       # 模型模块任务
│       ├── data-repositories.md # 仓库实现任务
│       ├── data-datasources.md  # 数据源任务
│       ├── domain-repositories.md # 仓库接口任务
│       ├── domain-usecases.md   # 用例任务
│       ├── presentation-pages.md # 页面任务
│       ├── presentation-widgets.md # 组件任务
│       ├── presentation-providers.md # Providers任务
│       ├── services-notification.md # 通知服务任务
│       ├── services-calendar.md # 日历服务任务
│       └── services-cache.md    # 缓存服务任务
├── lib/                         # 源代码
│   ├── core/
│   ├── data/
│   ├── domain/
│   ├── presentation/
│   └── services/
└── test/                        # 测试代码
    ├── unit/
    ├── widget/
    └── mocks/
```
