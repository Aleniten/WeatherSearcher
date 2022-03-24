//
//  BaseViewController.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/16/22.
//

import Foundation
import UIKit
// BaseViewControoller for inheritance
class BaseViewController: UIViewController {
   
    var spinner = SpinnerView()
    
    override func viewDidLoad() {
        
    }
    // create the alert for present error or success
    func alertPresent(title: String, _ message: String) {
        
               let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
    }
    // func that convert UIview in UIImage use in CityDetailsViewController
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
    // func to show spinner
    func showSpinner(_ superView: UIView){
        if !spinner.isShowing {
            self.spinner.display(onView: superView)
        }
//        if !isShowing {
//
//        }
    }
    // func to remove spinner
    func removeSpinner(_ delay: Double) {
        if spinner.isShowing {
            self.delay(delay, closure: {
                self.spinner.remove()
            })
        }
    }
    // func to delay actions i use to remove the spinner spinner because data was getting to quickly
    func delay (_ delay: Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
