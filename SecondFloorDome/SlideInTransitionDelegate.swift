//
//  SlideInTransitionDelegate.swift
//  xiyaSwift
//
//  Created by liuyihua on 2024/10/24.
//

import UIKit

class SlideInTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInTransitionAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInTransitionAnimator(isPresenting: false)
    }
}
