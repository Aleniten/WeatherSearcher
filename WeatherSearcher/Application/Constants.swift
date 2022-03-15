//
//  Colors.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import UIKit

struct Constants {
    
    struct Colors {
        
        static let backgroundGray = UIColor(red: 0.81, green: 0.84, blue: 0.88, alpha: 1.00)
        static let textGray = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.00)
        static let mainColor = UIColor(red: 0.19, green: 0.71, blue: 0.62, alpha: 1.00)
        static let whiteGray =  UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
        static let blackColor = UIColor(red: 0.13, green: 0.18, blue: 0.24, alpha: 1.00)
        static let favoriteYellow = UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00)
    }
    
    struct Fonts {
        static let TabbarFont = UIFont(name: "Avenir", size: 21)
        static let searchFont = UIFont(name: "Avenir", size: 16)
        static let title = UIFont(name: "Avenir", size: 18)
        static let subtitle = UIFont(name: "Avenir", size: 16)
    }
    
    struct LocalSpacing {
        static let buttonSizeSmall = CGFloat(44)
        static let buttonSizelarge = CGFloat(120)
    }
}

