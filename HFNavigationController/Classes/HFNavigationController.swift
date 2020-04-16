//
//  HFNavigationController.swift
//  Tmp_Example
//
//  Created by Bin Shang on 2019/12/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
/// 半屏弹窗导航控制器
public class HFNavigationController: UINavigationController {
    
    public var tapBackViewDismiss: Bool = false
    
    private lazy var animatorShow: HFTransitionAnimator = {
        let animator = HFTransitionAnimator(isEnter: true, animateType: .bottom)
        return animator
    }()
    
    private lazy var animatorHide: HFTransitionAnimator = {
        let animator = HFTransitionAnimator(isEnter: false, animateType: .top)
        return animator
    }()
    
    // MARK: -lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: HFPresentationController.notiNameDismissKey, object: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(popToRootController), name: HFPresentationController.notiNameDismissKey, object: nil)
    }
    
    @objc func popToRootController() {
        if tapBackViewDismiss == false {
            return
        }
        popToRootViewController(animated: false)
        dismiss(animated: true, completion: nil)
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
    ///设置show/hide动画方式
    public func setAnimateType(_ type: HFTransitionAnimator.AnimateType, isShow: Bool) {
        if isShow == true {
            animatorShow.animateType = type
        } else {
            animatorHide.animateType = type
        }
    }
}

extension HFNavigationController: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationVC = HFPresentationController(presentedViewController: presented,
                                                               presenting: presentingViewController)
        return presentationVC
    }

//    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return animatorShow
//    }
//
//    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return animatorHide
//    }
}
