//
//  AppDelegate.swift
//  Task001
//
//  Created by Bhavin J kansara on 6/16/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var navigationController:UINavigationController?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let listViewVC = ListViewVC.init(nibName: "ListViewVC", bundle: nil)
        navigationController = UINavigationController.init(rootViewController: listViewVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

   

}

