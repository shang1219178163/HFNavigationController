//
//  HFNavigationController.swift
//  Tmp_Example
//
//  Created by Bin Shang on 2019/12/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
/// 半屏弹窗导航控制器
open class HFNavigationController: UINavigationController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
          
}

public class HFPresentationNavController : UIPresentationController {
    
    public static let dismissKey = "HFPresentBottomDismissKey"
    /// 屏幕宽度
    public let kScreenWidth: CGFloat = UIScreen.main.bounds.width;
    /// 屏幕高度
    public let kScreenHeight: CGFloat = UIScreen.main.bounds.height;
        
    /// 动画持续时间
    public var kAnimDuration: TimeInterval = 0.35;
    
    /// 初始值默认半屏高度
    public var defaultFrame = CGRect(x: 0,
                                     y: UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.5,
                                     width: UIScreen.main.bounds.width,
                                     height: UIScreen.main.bounds.height*0.5)

    /// black layer
    lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    /// add dimView to the container and let alpha animate to 1 when show transition will begin
    public override func presentationTransitionWillBegin() {
        dimView.alpha = 0
        containerView?.addSubview(dimView)
        UIView.animate(withDuration: kAnimDuration) {
            self.dimView.alpha = 1
        }
    }
    
    /// let dimView's alpha animate to 0 when hide transition will begin.
    public override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: kAnimDuration) {
            self.dimView.alpha = 0
        }
    }
    
    /// remove the dimView when hide transition end
    ///
    /// - Parameter completed: completed or no
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimView.removeFromSuperview()
        }
    }
    
    /// define the frame of bottom view
    public override var frameOfPresentedViewInContainerView: CGRect {
        return defaultFrame
    }
    /// preferredContentSize 会触发此回调
    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
//        print(#function, container.preferredContentSize, frameOfPresentedViewInContainerView)
    
        if container.preferredContentSize == CGSize.zero {
            return
        }
        
        let rect = CGRect(x: (kScreenWidth - container.preferredContentSize.width)*0.5,
                          y: kScreenHeight - container.preferredContentSize.height,
                          width: container.preferredContentSize.width,
                          height: container.preferredContentSize.height)

        UIView.animate(withDuration: kAnimDuration) {
            self.presentedView?.frame = rect;
            if self.defaultFrame.maxY < self.kScreenHeight {
                let center = CGPoint(x: self.defaultFrame.minX + self.defaultFrame.width*0.5,
                                     y: self.defaultFrame.minY + self.defaultFrame.height*0.5);
                self.presentedView?.center = center;
            }
            
            self.presentedView?.layoutIfNeeded()
        }
    }
    
    @objc func dismiss() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: HFPresentationNavController.dismissKey), object: nil)
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension HFNavigationController: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationVC = HFPresentationNavController(presentedViewController: presented,
                                                               presenting: presentingViewController)
        return presentationVC
    }
}


