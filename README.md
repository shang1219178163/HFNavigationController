# HFNavigationController

[![CI Status](https://img.shields.io/travis/shang1219178163/HFNavigationController.svg?style=flat)](https://travis-ci.org/shang1219178163/HFNavigationController)
[![Version](https://img.shields.io/cocoapods/v/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)
[![License](https://img.shields.io/cocoapods/l/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/HFNavigationController.svg?style=flat)](https://cocoapods.org/pods/HFNavigationController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![动态效果图](https://github.com/shang1219178163/HFNavigationController/blob/master/HFNavigationController.gif?raw=true)

![控制器弹窗](https://github.com/shang1219178163/HFNavigationController/blob/develop/screenshots/Simulator%20Screen%20Shot.png?raw=true)

![导航控制器弹窗](https://github.com/shang1219178163/HFNavigationController/blob/develop/screenshots/Simulator%20Screen%20Shot1.png?raw=true)

## Requirements
    s.ios.deployment_target = '12.0'
    s.swift_version = "5.0"

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

## Author

shang1219178163, shang1219178163@gmail.com

## License

HFNavigationController is available under the MIT license. See the LICENSE file for more info.
