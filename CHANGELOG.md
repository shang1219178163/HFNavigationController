## [1.5.1] - 2026-09-17

### 文档
- README 修复首个动图链接（此前指向仓库根目录的 `HFNavigationController.gif`，
  该路径不存在，图片一直无法显示），并将三张图片的分支统一为 `master`
- README 的 `Requirements` 由裸代码块改为 `iOS 12.0+ / Swift 5.0+` 列表
- README 更新 `screenshots/HFNavigationController.gif` 为最新录制的示例动图

> 本版本不包含代码变更，仅文档与示例资源更新。

## [1.5.0] - 2026-09-17

### 新增

- 支持 Swift Package Manager，与 CocoaPods 共用同一份源码，模块名保持一致，
  下游 `import HFNavigationController` 无需改动
- `update.sh` 发版流程在打 tag 前增加 `Package.swift` 校验，避免损坏的
  manifest 随 tag 永久固化

### 变更

- **最低支持版本由 iOS 9.0 提升至 iOS 12.0（破坏性变更）**：Xcode 15 起工具链
  移除了 `libarclite`，部署目标低于 12.0 的 target 在链接阶段会失败
- `Example/Podfile` 增加 `post_install`，将第三方依赖（SnapKit、SwiftExpand）
  的部署目标统一提升到 12.0

### 修复

- 修复左右方向进出时卡片高度跳变：`frameOfPresentedViewInContainerView` 此前
  直接返回 `defaultFrame`，完全忽略 `preferredContentSize`，而后者走
  `updatePresentedView` 单独设置尺寸，转场动画覆盖了它导致高度在两个值之间跳变。
  现将两条路径统一到 `frameForPresentedView()`
- 修复 `pod install` 失败：SwiftExpand 4.8.0 的 tag 已从远端删除，导致 clone
  阶段必然失败，锁定到远端现存且内容一致的 4.8.1
- 删除仓库根目录遗留的悬空符号链接 `_Pods.xcodeproj`（指向已 gitignore 的
  `Example/Pods/`），该文件会导致 `xcodebuild` 与 SPM 在仓库根直接报错

### 已知问题

- `UserDefaults+Ex.swift` 中的 `NSKeyedArchiver.archivedData(withRootObject:)`
  与 `NSKeyedUnarchiver.unarchiveObject(with:)` 自 iOS 12 起被弃用，尚未迁移到
  `requiringSecureCoding` 版本，构建时会产生两条警告
- `HFTransitionAnimator.init(animateType:)` 与 `animateType` 为 internal，
  外部无法直接构造该转场动画器，只能经由 `setAnimateType(_:isShow:)` 使用

## [1.4.3] - 2021-07-01

### 变更

- 代码规范整理

## [1.4.2] - 2020-11-27

### 变更

- 优化代码，提高易用性和可读性

## [1.4.1] - 2020-11-24

### 新增

- 新增 `HFViewController` 控制器弹窗（优点：少声明一个变量；缺点：需要继承）

## [1.4.0] - 2020-11-24

### 新增

- 新增半屏弹窗导航控制器能力，提供 `defaultFrame` / `defaultSize` /
  `defaultHeight` 三种尺寸设置方式

## [1.0.0] - 2019-12-16

### 新增

- 首个发布版本：半屏弹窗导航控制器
