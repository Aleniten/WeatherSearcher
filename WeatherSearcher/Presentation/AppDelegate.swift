//
//  AppDelegate.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import UIKit
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = Constants.Colors.backgroundGray
        
        let navigationController = UINavigationController(rootViewController: SearcherCitiesViewController())
        navigationController.navigationBar.backgroundColor = Constants.Colors.mainColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: Constants.Fonts.TabbarFont]
        navigationController.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        window?.rootViewController = navigationController
        
        return true
    }

}

