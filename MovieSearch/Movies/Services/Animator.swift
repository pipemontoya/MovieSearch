//
//  Animator
//  MovieSearch
//
//  Created by Andres Montoya on 8/1/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to) ?? UIView()
        let movieDetail = presenting ? toView : transitionContext.view(forKey: .from)!
        let initialFrame = presenting ? originFrame : movieDetail.frame
        let finalFrame = presenting ? movieDetail.frame : originFrame
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            movieDetail.transform = scaleTransform
            movieDetail.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            movieDetail.clipsToBounds = true
        }
        duration = presenting == true ? 0.8 : 0.5
        movieDetail.layer.cornerRadius = presenting ? 20.0 : 0.0
        movieDetail.layer.masksToBounds = true
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(movieDetail)
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            animations: {
                movieDetail.transform = self.presenting ? .identity : .init(scaleX: 0.01, y: 0.01)
                movieDetail.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                movieDetail.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
        }, completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
