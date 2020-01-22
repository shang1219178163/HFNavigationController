//
//  HFPresentationNavController.swift
//  HFNavigationController
//
//  Created by Bin Shang on 2019/12/17.
//

import UIKit

public class HFPresentationController : UIPresentationController {
    
    public static let dismissKey = "HFPresentBottomDismissKey"
    /// 屏幕宽度
    public let kScreenWidth: CGFloat = UIScreen.main.bounds.width;
    /// 屏幕高度
    public let kScreenHeight: CGFloat = UIScreen.main.bounds.height;
        
    /// 动画持续时间
    public var kAnimDuration: TimeInterval = 0.35;
    
    /// 初始值默认半屏高度
    private var showFrame = CGRect(x: 0,
                                   y: UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.5,
                                    width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height*0.5)
    
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
    
//    public var defaultFrame: CGRect{
//        set{
//            let data = NSKeyedArchiver.archivedData(withRootObject: NSValue(cgRect: newValue))
//            UserDefaults.standard.set(data, forKey: "defaultFrame")
//            UserDefaults.standard.synchronize()
//        }
//        get{
//            guard let data = UserDefaults.standard.object(forKey: "defaultFrame") as? Data else {
//                return showFrame;
//            }
//            guard let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSValue else {
//                return showFrame;
//            }
//
//            if !CGRect.zero.equalTo(value.cgRectValue) {
//                return value.cgRectValue;
//            }
//            return showFrame;
//        }
//    }
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
//            print(#function,self.defaultFrame.maxY)
            self.presentedView?.layoutIfNeeded()
        }
    }
    
    @objc func dismiss() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: HFPresentationController.dismissKey), object: nil)
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
