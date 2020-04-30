//
//  UIViewControllerTransitionAnimator.swift
//  CustomTransitions
//
//  Created by Bin Shang on 2020/4/14.
//  Copyright © 2020 江涛. All rights reserved.
//

import UIKit


public class HFTransitionAnimator: NSObject {
    public enum AnimateType: Int {
        case fade
        case top
        case left
        case bottom
        case right
    }
    
    var animateType: AnimateType = .fade
    public var duration: TimeInterval = 0.25

    init(animateType: AnimateType) {
        self.animateType = animateType
    }
}

extension HFTransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        HFTransitionAnimator.animateTransition(using: transitionContext,
                                               duration: duration,
                                               type: animateType)
    }
}

extension HFTransitionAnimator {
    
    static func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                  duration: TimeInterval,
                                  type: AnimateType = .fade) {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) ?? fromVC.view,
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) ?? toVC.view
            else { return }
        
        let containerView = transitionContext.containerView
        
        let fromViewFrame = transitionContext.initialFrame(for: fromVC)
        let toViewFrame = transitionContext.finalFrame(for: toVC)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

//        print("\(#function)0_\(fromView.frame)_\(toView.frame)")
        let isShow = (toVC.isMovingToParent || toVC.isBeingPresented)
//        let isDismiss = fromVC.isMovingFromParent || fromVC.isBeingDismissed
//        print("\(#function)_isShow:\(isShow)_isDismiss:\(isDismiss)")

        var offset: CGVector = .zero
        if type == .left || type == .right {
            let dx = (type == .left) ? -1.0 : 1.0
            offset = CGVector(dx: dx, dy: 0)
        
            if isShow == true {
                toView.frame = toViewFrame.offsetBy(dx: screenWidth * offset.dx, dy: 0)
            } else {
                fromView.frame = fromViewFrame
            }
        } else if type == .top || type == .bottom {
            let dy = (type == .top) ? -1.0 : 1.0
            offset = CGVector(dx: 0, dy: dy)

            if isShow == true {
                toView.frame = toViewFrame.offsetBy(dx: 0, dy: screenHeight * offset.dy)
            } else {
                fromView.frame = fromViewFrame
            }
        } else {
            if isShow == true {
                toView.frame = toViewFrame
                toView.alpha = 0.0

            } else {
                fromView.frame = fromViewFrame
                fromView.alpha = 1.0
            }
        }

//        print("\(#function)1_\(fromView.frame)_\(toView.frame)")
        containerView.addSubview(toView)

        UIView.animate(withDuration: duration, animations: {

            if type == .left || type == .right {
                if isShow == true {
                    toView.frame = toViewFrame
                } else {
                    fromView.frame = fromViewFrame.offsetBy(dx: screenWidth * offset.dx * -1, dy: 0)
                }
                toView.alpha = 1.0
                fromView.alpha = 1.0

            } else if type == .top || type == .bottom {
                if isShow == true {
                    toView.frame = toViewFrame
                } else {
                    fromView.frame = fromViewFrame.offsetBy(dx: 0, dy: screenHeight * offset.dy * -1)
                }
                toView.alpha = 1.0
                fromView.alpha = 1.0
            } else {
                if isShow == true {
                    toView.alpha = 1.0

                } else {
                    fromView.alpha = 0.0
                }
            }
            
//            print("\(#function)后:_\(fromView.frame)_\(toView.frame)")

        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
            if wasCancelled == false {
                UIApplication.shared.keyWindow?.addSubview(toVC.view)
            }
        }
        
    }

}
