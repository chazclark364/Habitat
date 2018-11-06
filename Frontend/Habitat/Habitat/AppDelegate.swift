//
//  AppDelegate.swift
//  Habitat
//
//  Created by Chaz Clark on 9/6/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if (UserDefaults.standard.string(forKey: "email") != "" && UserDefaults.standard.string(forKey: "password") != "") {
            if let email = UserDefaults.standard.string(forKey: "email"), let password = UserDefaults.standard.string(forKey: "password") {
                HabitatAPI.UserAPI().loginUser(email: email, password: password, completion: {  user in
                    if let userReturned = user {
                        UserDefaults.standard.set(userReturned.firstName, forKey: "userFirstName")
                        UserDefaults.standard.set(userReturned.lastName, forKey:"userLastName")
                        UserDefaults.standard.set(userReturned.email, forKey: "userEmail")
                        UserDefaults.standard.set(userReturned.phoneNumber, forKey: "userPhoneNumber")
                        UserDefaults.standard.set(userReturned.type, forKey: "userType")
                        UserDefaults.standard.set(userReturned.userId, forKey: "userID")
                        UserDefaults.standard.set(userReturned.password, forKey: "password")
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        var profileViewController: ProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileViewController

                        self.window?.rootViewController = profileViewController
                        self.window?.makeKeyAndVisible()
                    }
                })
            }
        }
        // Override point for customization after application launch.
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


}

