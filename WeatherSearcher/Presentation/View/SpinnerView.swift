//
//  SpinnerView.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/16/22.
//

import Foundation
import UIKit

class SpinnerView: UIView {
        
    var isShowing: Bool = false
        
    func display(onView: UIView) {
        self.frame = onView.bounds
        self.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = self.center
        
        DispatchQueue.main.async {
            self.addSubview(ai)
            onView.addSubview(self)
        }
        
        self.isShowing = true
    }
    
    func remove() {
        DispatchQueue.main.async {
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            
            self.removeFromSuperview()
        }
        
        self.isShowing = false
    }
}
