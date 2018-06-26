//
//  AppDelegate.swift
//  note
//
//  Created by 笠原未来 on 2018/05/15.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var selectedDate: Date!
    var image: UIImage!
    var index: Int!
    
    var dateArray: [Date] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // アプリ起動時に呼ばれる
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("アプリ閉じた時")
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self as? UNUserNotificationCenterDelegate
//        
//        let content = UNMutableNotificationContent()
//        content.title = "タイトルだよ"
//        content.body = "通知だよ"
//        content.badge = 1
//        content.sound = .default()
//        // let component = DateComponents(calendar: Calendar.current, year: 2017, month: 3, day: 27, hour: 23, minute: 30)
//        // 指定した秒数後に通知
//        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        // 毎日21時に通知が来る
//        let date = DateComponents(hour:21, minute:0)
//        let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats: true)
//        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
//        
//        center.add(request)
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

