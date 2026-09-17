//
//  HFPresentationNavController.swift
//  HFNavigationController
//
//  Created by Bin Shang on 2019/12/17.
//

import UIKit

public class HFPresentationController : UIPresentationController {
    
    public static let notiNameDismissKey = NSNotification.Name(rawValue: "HFPresentBottomDismissKey")
        
    /// 动画持续时间
    public var animDuration: TimeInterval = 0.35;
    
    /// 初始值默认半屏高度
    private var showFrame = CGRect(x: 0,
                                   y: UIScreen.sizeHeight - UIScreen.sizeHeight*0.5,
                                   width: UIScreen.sizeWidth,
                                   height: UIScreen.sizeHeight*0.5)
    
    public var defaultFrame: CGRect{
        set{
            UserDefaults.setArcObject(NSValue(cgRect: newValue), forkey: "defaultFrame")
            UserDefaults.standard.synchronize()
        }
        get{
            guard let value = UserDefaults.unarcObject(forkey: "defaultFrame") as? NSValue else {
                return showFrame;
            }
            return value.cgRectValue;
        }
    }
    
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
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) -> Void in
                self.dimView.alpha = 1
            }, completion: nil)
        } else {
            UIView.animate(withDuration: animDuration) {
                self.dimView.alpha = 1
            }
        }
    }
    
    /// let dimView's alpha animate to 0 when hide transition will begin.
    override public func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) -> Void in
                self.dimView.alpha = 0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: animDuration) {
                self.dimView.alpha = 0
            }
        }
    }

    /// remove the dimView when hide transition end
    /// - Parameter completed: completed or no
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimView.removeFromSuperview()
            dismiss()
        }
    }
    
    /// preferredContentSize 指定过的尺寸；未指定时为 .zero，此时沿用 defaultFrame
    private var preferredSize: CGSize = .zero

    /// define the frame of bottom view
    /// 与 updatePresentedView 共用同一套计算，避免转场动画的 finalFrame
    /// 覆盖掉 preferredContentSize 算出的尺寸，导致进出时高度跳变
    public override var frameOfPresentedViewInContainerView: CGRect {
        return frameForPresentedView()
    }

    private func frameForPresentedView() -> CGRect {
        guard preferredSize != .zero else {
            return defaultFrame
        }
        if preferredSize.height >= UIScreen.sizeHeight {
            return CGRect(x: 0,
                          y: 0,
                          width: preferredSize.width,
                          height: preferredSize.height)
        }
        let rect = CGRect(x: (UIScreen.sizeWidth - preferredSize.width)*0.5,
                          y: UIScreen.sizeHeight - preferredSize.height,
                          width: preferredSize.width,
                          height: preferredSize.height)
        // 非贴底配置（center/top）时以 defaultFrame 中心对齐，与原有行为一致
        if defaultFrame.maxY < UIScreen.sizeHeight {
            return CGRect(x: defaultFrame.midX - rect.width*0.5,
                          y: defaultFrame.midY - rect.height*0.5,
                          width: rect.width,
                          height: rect.height)
        }
        return rect
    }

    /// preferredContentSize 会触发此回调
    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if container.preferredContentSize == CGSize.zero {
            return
        }
        updatePresentedView(container.preferredContentSize)
    }

    ///更新视图大小
    @objc func updatePresentedView(_ preferredContentSize: CGSize) {
        preferredSize = preferredContentSize
        UIView.animate(withDuration: animDuration) {
            self.presentedView?.frame = self.frameForPresentedView()
            self.presentedView?.layoutIfNeeded()
        }
    }
    
    @objc func dismiss() {
        NotificationCenter.default.post(name: HFPresentationController.notiNameDismissKey, object: nil)
//        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
