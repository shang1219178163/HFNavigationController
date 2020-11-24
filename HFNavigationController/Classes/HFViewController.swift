//
//  HFViewController.swift
//  Pods
//
//  Created by Bin Shang on 2020/11/24.
//

import UIKit

/// 半屏弹窗控制器(需继承此类)
@objcMembers open class HFViewController: UIViewController {
    
    public var tapBackViewDismiss: Bool = true
    
    private lazy var animatorShow: HFTransitionAnimator = {
        let animator = HFTransitionAnimator(animateType: .bottom)
        return animator
    }()
    
    private lazy var animatorHide: HFTransitionAnimator = {
        let animator = HFTransitionAnimator(animateType: .top)
        return animator
    }()
    
    // MARK: -lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: HFPresentationController.notiNameDismissKey, object: nil)
        removeObserver(self, forKeyPath: "preferredContentSize", context: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white;
        modalPresentationStyle = .custom;
        transitioningDelegate = self;
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dismissController),
                                               name: HFPresentationController.notiNameDismissKey,
                                               object: nil)
        
        addObserver(self, forKeyPath: "preferredContentSize", options: .new
            , context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print("\(NSDate())\(#function)\(keyPath)")
        if keyPath == "preferredContentSize" {
            guard let value = change![NSKeyValueChangeKey.newKey] as? NSValue else { return }
            updatePresentedView(value.cgSizeValue)
        }
    }
    
    @objc func dismissController() {
        if tapBackViewDismiss == false {
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - funtions
    /// 设置默认位置
    public func setupDefaultFrame(_ rect: CGRect) {
        if let presentationController = presentationController as? HFPresentationController{
            presentationController.defaultFrame = rect
        }
    }
    
    public func updatePresentedView(_ preferredContentSize: CGSize) {
        guard let presentationController = presentationController as? HFPresentationController else { return }
        presentationController.updatePresentedView(preferredContentSize)
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

extension HFViewController: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationVC = HFPresentationController(presentedViewController: presented,
                                                               presenting: presentingViewController)
        return presentationVC
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatorShow
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatorHide
    }
}
