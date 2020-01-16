//
//  HFViewController.swift
//  Tmp_Example
//
//  Created by Bin Shang on 2019/12/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
/// 半屏弹窗控制器
open class HFViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - funtions
    /// 设置默认位置
    public func setupDefaultFrame(_ rect: CGRect) {
        if let presentationController = presentationController as? HFPresentationController{
            presentationController.defaultFrame = rect
        }
    }
    /// 设置默认高度
    public func setupDefaultHeight(_ height: CGFloat) {
        if let presentationController = presentationController as? HFPresentationController{
            let rect = CGRect(x: 0,
                                     y: UIScreen.main.bounds.height - height,
                                     width: UIScreen.main.bounds.width,
                                     height: height)
            presentationController.defaultFrame = rect
        }
    }
}

extension HFViewController: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationVC = HFPresentationController(presentedViewController: presented,
                                                               presenting: presentingViewController)
        return presentationVC
    }
}


