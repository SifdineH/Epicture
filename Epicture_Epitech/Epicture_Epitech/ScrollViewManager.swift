//
//  ScrollViewManager.swift
//  Epicture_Epitech
//
//  Created by Flo on 09/11/2018.
//  Copyright © 2018 Flo. All rights reserved.
//

import UIKit

class ScrollViewManager: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let panGesture = UIPanGestureRecognizer(target: self, action:
            #selector(panView(with:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func panView(with gestureReconizer: UIPanGestureRecognizer) {
        let translation = gestureReconizer.translation(in: self)
        if (self.bounds.origin.y >= 0) {
            UIView.animate(withDuration: 0.10) {
                self.bounds.origin.y = self.bounds.origin.y - translation.y
                gestureReconizer.setTranslation(CGPoint.zero, in: self)
            }
        } else {
            UIView.animate(withDuration: 0.20) {
                self.bounds.origin.y = 0
                gestureReconizer.setTranslation(CGPoint.zero, in: self)
            }
        }
    }
}
