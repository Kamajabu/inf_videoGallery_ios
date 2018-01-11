//
//  UIImageView+Extensions.swift
//  infGalleryIOS
//
//  Created by Kamil Buczel on 29.03.2017.
//  Copyright © 2017 Kamajabu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }

    func removeBlurEffect() {
        for subview in self.subviews where subview is UIVisualEffectView {
            subview.removeFromSuperview()
        }
    }

    func animatedRemoveBlurEffect() {
        for subview in self.subviews where subview is UIVisualEffectView {
            UIView.animate(withDuration: 0.5, animations: { subview.alpha = 0.0 } ,
                           completion: { (value: Bool) in
                            subview.removeFromSuperview()
            } )
        }
    }

    func addAnimatedBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation

        UIView.transition(with: self, duration: 0.4,
                          options: .transitionCrossDissolve, animations: {
            self.addSubview(blurEffectView)
        }, completion: nil)
    }
}
