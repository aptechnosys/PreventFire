//
//  AppDelegate.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/31/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.initializeApplication()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device token: \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
}

// MARK: - Init
extension AppDelegate {
    
    func initializeApplication() {
        //Fabric.with([Crashlytics.self])
        UITextView.appearance().tintColor = UIColor.white
        //IQKeyboardManager.shared().isEnabled = true
        configureAppEnvironmentSettings()
        GooglePlacesHandler.shared.provideAPIKey()
        if checkIfUserloggedIn() {
            setRootMenuViewController()
        } else {
            setLanguageViewController()
        }
    }
    
    func checkIfUserloggedIn() -> Bool {
        let userId = UserDefaults.standard.getUserId()
        if userId == nil {
            SessionData.shared.isLoggedInUser = false
            return false
        }
        SessionData.shared.isLoggedInUser = true
        return true
    }
    
    func setLanguageViewController() {
        let storyborad = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: nil)
        let languageViewController = storyborad.instantiateViewController(withIdentifier: "LanguageViewController")
        let navigationController = UINavigationController(rootViewController: languageViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func setRootLoginViewController() {
        let storyborad = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: nil)
        let loginViewController = storyborad.instantiateViewController(withIdentifier: "LoginViewController")
        let navigationController = UINavigationController(rootViewController: loginViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func setRootHomeViewController() {
        // self.window?.rootViewController = HomeTabBarController()
        // self.window?.makeKeyAndVisible()
    }
    
    func configureAppEnvironmentSettings() {
        APPURL.setDevelopmentEnvironment(.production)
        Localization.setLanguage(.english)
    }
    
    func pushtoCategoryView() {
        let storyborad = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: nil)
        let categoryViewController = storyborad.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
        let navigationController = UINavigationController(rootViewController: categoryViewController!)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func setRootMenuViewController() {
        if let menuViewController = UIStoryboard(name: StoryBoardName.menu.rawValue, bundle: Bundle.main).instantiateInitialViewController() {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = menuViewController
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    func setRootMenuViewController1() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = HomeTabBarController()
            self.window?.makeKeyAndVisible()
        }
    }
    
    
    class func delegate() -> AppDelegate? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate
    }
    
}
