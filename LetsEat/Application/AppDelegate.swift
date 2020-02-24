//
//  AppDelegate.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 01.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootController: UIViewController?
    
    public static var networkService: NetworkService = {
        let configuration: NetworkConfiguration
        #if DEBUG
        configuration = LocalNetworkConfiguration()
        #elseif HEROKU_DEBUG
        configuration = HerokuNetworkConfiguration()
        #else
        configuration = HerokuNetworkConfiguration()
        #endif
        
        return NetworkService(networkConfiguration: configuration)
    }()
    
    public static var restaurantDataSourceFabric: RestaurantDataSourceFabric = {
        #if DEBUG
        return PlistRestaurantDataSourceFabric()
        #else
        return NetworkRestaurantDataSourceFabric()
        #endif
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialize()
        setupWindow()
        checkNotifications()
        return true
    }

    func checkNotifications() {
       UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
        let optionOne = UNNotificationAction(identifier: Option.one.rawValue, title: "Yes", options: [.foreground])
        let optionTwo = UNNotificationAction(identifier: Option.two.rawValue, title: "No", options: [.foreground])
        let category = UNNotificationCategory(identifier: Identifier.reservationCategory.rawValue, actions: [optionOne, optionTwo], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
       }
    }
    
    private func setupWindow() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        rootController = mainStoryboard.instantiateInitialViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        injectDataSourceFabric()
    }
    
    private func injectDataSourceFabric() {
        guard let tabBarController = rootController as? UITabBarController,
            let exploreNavigationController = tabBarController.viewControllers?[0] as? UINavigationController,
            let mapNavigationController = tabBarController.viewControllers?[1] as? UINavigationController else {
                return
        }
        if let exploreController = exploreNavigationController.viewControllers[0] as? ExploreViewController {
            exploreController.restaurantDataSourceFabric = type(of: self).restaurantDataSourceFabric
        }
        if let mapController = mapNavigationController.viewControllers[0] as? MapViewController {
            mapController.manager = type(of: self).restaurantDataSourceFabric.mapDataSource
        }
    }
}

private extension AppDelegate {
    func initialize() {
        setupDefaultColors()
    }

    func setupDefaultColors() {
        guard let red = UIColor(named: "LetsEat Red") else { return }
        UITabBar.appearance().tintColor = red
        UITabBar.appearance().barTintColor = .white
        UITabBarItem.appearance()
            .setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.black],
                for: UIControl.State.normal)
        UITabBarItem.appearance()
            .setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: red],
                for: UIControl.State.selected)
        UINavigationBar.appearance().tintColor = red
        UINavigationBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = true
        UINavigationBar.appearance().isTranslucent = true
    }
}
