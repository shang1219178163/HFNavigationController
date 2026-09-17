# HFNavigationController


## Author

shang1219178163, shang1219178163@gmail.com

## License

HFNavigationController is available under the MIT license. See the LICENSE file for more info.

[![CI Status](https://img.shields.io/travis/shang1219178163/HFNavigationController.svg?style=flat)](https://travis-ci.org/shang1219178163/HFNavigationController)
[![Version](https://img.shields.io/cocoapods/v/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)
[![License](https://img.shields.io/cocoapods/l/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)

版本变更记录见 [CHANGELOG.md](CHANGELOG.md)。维护者发版流程见[发布](#发布)。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<p>
<img src="https://github.com/shang1219178163/HFNavigationController/blob/master/screenshots/HFNavigationController.gif?raw=true" alt="动态效果图" width="30%">
<img src="https://github.com/shang1219178163/HFNavigationController/blob/master/screenshots/Simulator%20Screen%20Shot.png?raw=true" alt="控制器弹窗" width="30%">
<img src="https://github.com/shang1219178163/HFNavigationController/blob/master/screenshots/Simulator%20Screen%20Shot1.png?raw=true" alt="导航控制器弹窗" width="30%">
</p>

## Requirements

- iOS 12.0+
- Swift 5.0+

## Installation

HFNavigationController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HFNavigationController'
```

It is also available through [Swift Package Manager](https://www.swift.org/package-manager/).
Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/shang1219178163/HFNavigationController.git", from: "1.5.0")
]
```

Then add `HFNavigationController` to your target's dependencies:

```swift
targets: [
    .target(name: "YourApp", dependencies: ["HFNavigationController"])
]
```

> **注意**：本库最低支持 iOS 12.0，请在消费方的 manifest 中声明
> `platforms: [.iOS(.v12)]`。SPM 不会自动抬高你的部署目标，若低于 12.0 会在
> 你这边报错。

## Usage
```
import HFNavigationController

class HomeViewController: UIViewController {
    //控制器弹窗
    lazy var controller: NNAlertViewController = {
        let controller = NNAlertViewController()        
        controller.view.layer.cornerRadius = 15
        controller.view.layer.masksToBounds = true
        return controller;
    }()
    //导航控制器弹窗
    lazy var navController: HFNavigationController = {
        let controller = HFNavigationController(rootViewController: FisrtViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = controller as UIViewControllerTransitioningDelegate
        return controller;
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        title = Bundle.localizedString(forKey: "半屏显示")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "导航控制器", style: .plain, target: self, action: #selector(handleItemRight))
        
    }
    
    @objc func handleItemRight() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(navController, animated: true, completion: nil)
        
    }
}

```

## 发布

> 本节面向本仓库维护者。`update.sh` 会提交、推送、打 tag 并把版本发布到
> CocoaPods trunk，**最后一步不可撤销**，请确认无误后再执行。

### 用法

脚本从**仓库根目录**运行，并通过**目录名**推导 podspec 文件名
（目录 `HFNavigationController` → `HFNavigationController.podspec`）：

```bash
./update.sh
```

终端编码需为 UTF-8：

```bash
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 ./update.sh
```

### 发版步骤

**1. 修改 podspec 版本号**

```ruby
s.version = '1.5.2'
```

**2. 在 CHANGELOG.md 中补上对应版本的条目**

**3. 确认工作区状态**

脚本使用 `git add .`，会把工作区中所有改动一并提交，包括构建脚本刷新的
`Example/HFNavigationController/Info.plist` 中的 `CFBundleVersion` 时间戳。
建议先 `git status` 确认没有不该提交的内容。

**4. 执行脚本**

```bash
./update.sh
```

### 脚本执行流程

`update.sh` 读取 podspec 中的版本号，依次执行：

| 步骤 | 动作 |
| --- | --- |
| 1 | `git pull` 拉取远端 |
| 2 | `git add .` + `git commit` |
| 3 | `git push` 推送分支 |
| 4 | `swift package dump-package` 校验 `Package.swift` |
| 5 | `git tag -a <版本号> -m "Release <版本号>"` |
| 6 | `git push --tags` 推送 tag |
| 7 | `pod trunk push` 发布到 CocoaPods trunk |

第 4 步的 manifest 校验在打 tag **之前**执行：tag 是 Swift Package Manager 的
不可变契约，一旦随损坏的 `Package.swift` 发布就无法补救。

### 注意事项

- **必须使用三段式版本号**（如 `1.5.2`）。四段式（如 `1.0.5.1`）不符合语义化
  版本规范，Swift Package Manager 无法解析。
- **已发布的 tag 不要移动**。改动已发布 tag 的指向会导致 Swift Package Manager
  的安全指纹校验失败（`does not match previously recorded value`）。需要修正时
  请发布新版本号。
- **`pod trunk push` 报 `Net::OpenTimeout` 不代表发布失败**。该错误可能是客户端
  等待响应超时、而服务端已完成。重试前先用 `pod trunk info HFNavigationController`
  确认版本是否已在 trunk 上，避免重复发布。

