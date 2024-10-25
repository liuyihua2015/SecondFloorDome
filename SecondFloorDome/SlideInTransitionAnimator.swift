//
//  SlideInTransitionAnimator.swift
//  xiyaSwift
//
//  Created by liuyihua on 2024/10/24.
//

import UIKit

class SlideInTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let toView = toViewController.view
        let fromView = fromViewController.view

        // 剩下的逻辑与之前相同
        let screenBounds = UIScreen.main.bounds
        let offScreenUp = CGAffineTransform(translationX: 0, y: -screenBounds.height)
        let offScreenDown = CGAffineTransform(translationX: 0, y: screenBounds.height)
        
        if isPresenting {
            toView?.transform = offScreenUp
            containerView.addSubview(toView!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView?.transform = .identity
                fromView?.alpha = 0.8
            }, completion: { _ in
                fromView?.alpha = 1.0
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            containerView.addSubview(toView!)
            containerView.sendSubviewToBack(toView!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.transform = offScreenDown
                toView?.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
