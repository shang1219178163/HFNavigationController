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
    public var kAnimDuration: TimeInterval = 0.35;
    
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
            UIView.animate(withDuration: kAnimDuration) {
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
            UIView.animate(withDuration: kAnimDuration) {
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
    
    /// define the frame of bottom view
    public override var frameOfPresentedViewInContainerView: CGRect {
        return defaultFrame
    }
    /// preferredContentSize 会触发此回调
    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if container.preferredContentSize == CGSize.zero {
            return
        }
        updatePresentedView(container.preferredContentSize)
    }
    
    @objc func updatePresentedView(_ preferredContentSize: CGSize) {
        if preferredContentSize.height >= UIScreen.sizeHeight {
            let rect = CGRect(x: 0,
                              y: 0,
                              width: preferredContentSize.width,
                              height: preferredContentSize.height)
              UIView.animate(withDuration: kAnimDuration) {
                  self.presentedView?.frame = rect;
                  self.presentedView?.layoutIfNeeded()
              }
            return
        }
        
        let rect = CGRect(x: (UIScreen.sizeWidth - preferredContentSize.width)*0.5,
                          y: UIScreen.sizeHeight - preferredContentSize.height,
                          width: preferredContentSize.width,
                          height: preferredContentSize.height)
        UIView.animate(withDuration: kAnimDuration) {
            self.presentedView?.frame = rect;
            if self.defaultFrame.maxY < UIScreen.sizeHeight {
                let center = CGPoint(x: self.defaultFrame.minX + self.defaultFrame.width*0.5,
                                     y: self.defaultFrame.minY + self.defaultFrame.height*0.5);
                self.presentedView?.center = center;
//                print("\(#function)_\(container.preferredContentSize)_\(self.defaultFrame)_\(self.presentedView!.frame)")

            }
            self.presentedView?.layoutIfNeeded()
        }
    }
    
    @objc func dismiss() {
        NotificationCenter.default.post(name: HFPresentationController.notiNameDismissKey, object: nil)
//        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
