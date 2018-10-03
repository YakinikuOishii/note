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
    var colorIndex: Int! = 0
    var tomorrowBool: Bool = true
    var dateArray: [Date] = []
    let bgColorArray: [String] = ["blue","green","orange","red","pink","purple","black"]
    var timeTitleArray: [String] = ["前日19時","前日20時","前日21時","前日22時","前日23時","当日0時","当日5時","当日6時","当日7時","当日8時","当日9時","当日10時"]

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
        // アプリ閉じた時
        
        //ローカル通知
//        let notification = UILocalNotification()
//        //ロック中にスライドで〜〜のところの文字
//        notification.alertAction = "アプリを開く"
//        //通知の本文
//        notification.alertBody = "ごはんたべよう！"
//        //通知される時間（とりあえず10秒後に設定）
//        notification.fireDate = NSDate(timeIntervalSinceNow:10) as Date
//        //通知音
//        notification.soundName = UILocalNotificationDefaultSoundName
//        //アインコンバッジの数字
//        notification.applicationIconBadgeNumber = 1
//        //通知を識別するID
//        notification.userInfo = ["notifyID":"gohan"]
//        //通知をスケジューリング
//        application.scheduleLocalNotification(notification)
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

