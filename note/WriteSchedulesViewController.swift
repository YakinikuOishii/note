//
//  WriteSchedulesViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/05/20.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class WriteSchedulesViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let drawView = DrawView()
    let realm = try! Realm()
    let dataSet = realmDataSet()
    let saveTime = UserDefaults.standard
    var saveColor = UserDefaults.standard
    
    var selectedDate: Date!
    var saveDate: Date!
    
    @IBOutlet var titleView: DrawView!
    @IBOutlet var memoView: DrawView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var titleDeleteButton: UIButton!
    @IBOutlet var memoDeleteButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var memoText: UILabel!
    
//    @IBOutlet var leftBurButtonItem: UIBarButtonItem!
//    @IBOutlet var rightBurButtonItem: UIBarButtonItem!
    
    var titleData: NSData!
    var memoData: NSData!
    var titleImage: UIImage!
    var memoImage: UIImage!
    
    var editMode: Bool = true
    
    var index: Int!
    
    let borderColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
    let blue = UIColor(red: 0.313, green: 0.662, blue: 0.945, alpha: 1.0)
    let green = UIColor(red: 0.145, green: 0.772, blue: 0.521, alpha: 1.0)
    let orange = UIColor(red: 1.0, green: 0.709, blue: 0.168, alpha: 1.0)
    let red = UIColor(red: 0.913, green: 0.317, blue: 0.301, alpha: 1.0)
    let pink = UIColor(red: 0.890, green: 0.417, blue: 0.596, alpha: 1.0)
    let purple = UIColor(red: 0.823, green: 0.0, blue: 1.0, alpha: 1.0)
    let black = UIColor(red: 0.160, green: 0.152, blue: 0.309, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = appDelegate.index
        
        for i in 0...6 {
            if appDelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appDelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
                imageView.image = UIImage(named: appDelegate.bgColorArray[i])
            }
        }
        textColor()
        
        selectedDate = appDelegate.selectedDate
        
        saveTime.object(forKey: "saveTime")
        
        titleView.layer.borderColor = borderColor.cgColor
        memoView.layer.borderColor = borderColor.cgColor
        titleView.layer.borderWidth = 1.5
        memoView.layer.borderWidth = 1.5
        
        if index == nil {
            print("新規登録")
            saveDate = appDelegate.selectedDate
            
        }else if index != nil {
            print("編集")
            let dataSet = realm.objects(realmDataSet.self).filter("date == %@", selectedDate).sorted(byKeyPath: "recordDate", ascending: true)
            var titleArray: [Data] = []
            var memoArray: [Data] = []
            
            for i in dataSet {
                titleArray.append(i.title!)
                memoArray.append(i.memo!)
                print("セルは\(index)番目")
                print("タイトルarrayは\(titleArray.count)個")
            }
            titleView.canvas.image = UIImage(data: titleArray[index!])
            titleView.lastDrawImage = UIImage(data: titleArray[index!])
            memoView.canvas.image = UIImage(data: memoArray[index!])
            memoView.lastDrawImage = UIImage(data: memoArray[index!])
        }
        
    }
    
    @IBAction func saveSchedules() {
        titleRepresentation()
        memoRepresentation()
        
        if titleView.canvas.image == nil {
            let title = "保存できません"
            let message = "タイトルを記入してください"
            let close = "閉じる"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let closeButton = UIAlertAction(title: close, style: .cancel, handler: nil)
            alert.addAction(closeButton)
            
            present(alert, animated: true, completion: nil)
        }else{
            if index == nil {
                print("新規保存")
                save()
                dismiss(animated: true, completion: nil)
            }else if index != nil {
                print("編集保存")
                let updateData = realm.objects(realmDataSet.self).filter("date == %@", selectedDate).sorted(byKeyPath: "recordDate", ascending: true)[index!]
                try! realm.write {
                    updateData.title = titleData! as Data
                    updateData.memo = memoData! as Data
                }
                dismiss(animated: true, completion: nil)
            }

        }
        
        
    }
    
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        
        // canvas.imageに代入する
        
        let dateWidget: UserDefaults! = UserDefaults(suiteName: "group.com.litech.note")
        dateWidget.set(selectedDate, forKey: "date")
        dateWidget.synchronize()
        
        let titleWidget: UserDefaults! = UserDefaults(suiteName: "group.com.litech.note")
        titleWidget.set(titleData, forKey: "title")
        titleWidget.synchronize()

        
        dataSet.date = selectedDate
        dataSet.recordDate = Date()
        dataSet.title = titleData! as Data
        dataSet.memo = memoData! as Data
        
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(dataSet)
            }
            
            // 通知
            let center = UNUserNotificationCenter.current()
            center.delegate = self as? UNUserNotificationCenterDelegate

            let content = UNMutableNotificationContent()
//            content.title = ""
//            content.body = "通知だよ"
            content.badge = 1
            content.sound = .default()
            let calendar = Calendar(identifier: .gregorian)
//            var components = calendar.dateComponents([.month, .day, .hour, .minute], from: saveDate)
            var yesterday = DateComponents()
            yesterday.day = -1
            let hour: Int! = saveTime.object(forKey: "saveTime") as? Int
            if appDelegate.tomorrowBool == true {
                print("通知呼ばれたtomorrow")
                content.title = "明日の予定があります"
                // カレンダー上でマイナス1日してくれる
                let tomorrowDate = calendar.date(byAdding: yesterday, to: saveDate)
                var tomorrowComponents = calendar.dateComponents([.month, .day, .hour], from: tomorrowDate!)
                if hour != nil {
                    tomorrowComponents.hour = hour
                }else{
                    tomorrowComponents.hour = 6
                }
                
                let trigger = UNCalendarNotificationTrigger.init(dateMatching: tomorrowComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
//                print(tomorrowComponents.hour as Any)
                center.add(request)
            }else{
                print("通知呼ばれたtoday")
                content.title = "今日の予定があります"
                var components = calendar.dateComponents([.month, .day, .hour], from: saveDate)
                if hour != nil {
                    components.hour = hour
                }else{
                    components.hour = 6
                }
                let trigger = UNCalendarNotificationTrigger.init(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
//                print(components.hour as Any)
                center.add(request)
            }
            
            
            
            
//            let components = DateComponents(day: 1, hour:8, minute:30)
//            let trigger = UNCalendarNotificationTrigger.init(dateMatching: tomorrowComponents, repeats: true)
//            let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
//            center.add(request)
            
        } catch {
            
        }
        
    }
    
    @IBAction func deleteTitle() {
//        titleView.removeFromSuperview()
//        titleView.lastDrawImage = UIImage(named: "cellImg")
        titleView.canvas.image = nil
        titleView.lastDrawImage = nil
        titleView.path = nil
        titleView.setNeedsDisplay()
        // viewを更新
        titleView.layoutIfNeeded()
    }
    
    @IBAction func deleteMemo() {
//        memoView.removeFromSuperview()
//        memoView.lastDrawImage = UIImage(named: "cellImg")
        memoView.canvas.image = nil
        memoView.lastDrawImage = nil
        memoView.path = nil
        memoView.setNeedsDisplay()
        memoView.layoutIfNeeded()
    }
    
    func titleRepresentation() {
        titleImage = titleView.snapShot()
        titleData = UIImagePNGRepresentation(titleImage)! as NSData
    }
    
    func memoRepresentation() {
        memoImage = memoView.snapShot()
        memoData = UIImagePNGRepresentation(memoImage)! as NSData
    }
    
    func textColor() {
        if appDelegate.colorIndex == 0 {
            titleText.textColor = blue
            memoText.textColor = blue
            titleDeleteButton.tintColor = blue
            memoDeleteButton.tintColor = blue
        }else if appDelegate.colorIndex == 1 {
            titleText.textColor = green
            memoText.textColor = green
            titleDeleteButton.tintColor = green
            memoDeleteButton.tintColor = green
        }else if appDelegate.colorIndex == 2 {
            titleText.textColor = orange
            memoText.textColor = orange
            titleDeleteButton.tintColor = orange
            memoDeleteButton.tintColor = orange
        }else if appDelegate.colorIndex == 3 {
            titleText.textColor = red
            memoText.textColor = red
            titleDeleteButton.tintColor = red
            memoDeleteButton.tintColor = red
        }else if appDelegate.colorIndex == 4 {
            titleText.textColor = pink
            memoText.textColor = pink
            titleDeleteButton.tintColor = pink
            memoDeleteButton.tintColor = pink
        }else if appDelegate.colorIndex == 5 {
            titleText.textColor = purple
            memoText.textColor = purple
            titleDeleteButton.tintColor = purple
            memoDeleteButton.tintColor = purple
        }else if appDelegate.colorIndex == 6 {
            titleText.textColor = black
            memoText.textColor = black
            titleDeleteButton.tintColor = black
            memoDeleteButton.tintColor = black
        }else{
            titleText.textColor = blue
            memoText.textColor = blue
            titleDeleteButton.tintColor = blue
            memoDeleteButton.tintColor = blue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
