//
//  BaseViewController.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/16/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
   
    var spinner = SpinnerView()
    
    override func viewDidLoad() {
        
    }
    
    func alertPresent(title: String, _ message: String) {
        // create the alert
               let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
    }
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func showSpinner(_ superView: UIView, _ isShowing: Bool){
        if !isShowing {
            self.spinner.display(onView: superView)
        }
    }
    
    func removeSpinner(_ delay: Double) {
        self.delay(delay, closure: {
            self.spinner.remove()
        })
    }
    
    func delay (_ delay: Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
