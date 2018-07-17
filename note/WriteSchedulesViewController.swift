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
    
    var selectedDate: Date!
    var saveDate: Date!
    var index: Int!
    
    @IBOutlet var titleView: DrawView!
    @IBOutlet var memoView: DrawView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var titleDeleteButton: UIButton!
    @IBOutlet var memoDeleteButton: UIButton!
    
    var titleData: NSData!
    var memoData: NSData!
    var titleImage: UIImage!
    var memoImage: UIImage!
    
    var editMode: Bool = true
    
    let borderColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = appDelegate.selectedDate
        titleView.layer.borderColor = borderColor.cgColor
        memoView.layer.borderColor = borderColor.cgColor
        titleView.layer.borderWidth = 1.5
        memoView.layer.borderWidth = 1.5
        
        index = appDelegate.index
        
        let dataSet = realm.objects(realmDataSet.self).filter("date == %@", selectedDate)
        var tableArray: [Data] = []
        var memoArray: [Data] = []
        if index != nil {
            print("indexは空じゃないよ")
            for i in dataSet {
                tableArray.append(i.title!)
                memoArray.append(i.memo!)
                titleView.lastDrawImage = UIImage(data: tableArray[index])
                memoView.lastDrawImage = UIImage(data: memoArray[index])
            }
        }else{
            saveDate = appDelegate.selectedDate
            print("indexは空だよ")
        }
        
        // 画像が表示されているかどうかで編集モードを切り替える
        if titleView.lastDrawImage != nil {
            print("編集")
            addButton.setImage(UIImage(named: "penIcon3.png"), for: UIControlState())
            
            // ビューに書き込めないようにする
            editMode = false
            titleView.editMode = false
            memoView.editMode = false
            print("viewdid")
            print("titleviewのbool")
            print(titleView.editMode)
            print("editModeのbool")
            print(editMode)
        }else{
            print("新規")
        }
        
    }
    
    @IBAction func saveSchedules() {
        titleRepresentation()
        memoRepresentation()
        
        if editMode == true {
            save()
            dismiss(animated: true, completion: nil)
            
        }else if editMode == false {
            print("viewのboolは")
            print(titleView.editMode)
            // 編集モードだったら、内容を更新して保存。新規セルを作らないように！
            if titleView.editMode == true {
                print("true呼ばれた")
                titleView.editMode = false
                memoView.editMode = false
                let appdateData = realm.objects(realmDataSet.self).filter("date == %@", selectedDate)[index]
                try! realm.write {
                    appdateData.title = titleData! as Data
                    appdateData.memo = memoData! as Data
                }
                dismiss(animated: true, completion: nil)
                
            }else if titleView.editMode == false {
                print("false呼ばれた")
                // 編集モードじゃなかったら、ボタンを変更して書き込めるようにする。
                titleView.editMode = true
                memoView.editMode = true
                addButton.setImage(UIImage(named: "checkMark.png"), for: UIControlState())
            }
        }
    }
    
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        
        let dateWidget: UserDefaults! = UserDefaults(suiteName: "group.com.litech.note")
        dateWidget.set(selectedDate, forKey: "date")
        dateWidget.synchronize()
        
        let titleWidget: UserDefaults! = UserDefaults(suiteName: "group.com.litech.note")
        titleWidget.set(titleData, forKey: "title")
        titleWidget.synchronize()

        
        dataSet.date = selectedDate
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
            content.title = "タイトルだよ"
            content.body = "通知だよ"
            content.badge = 1
            content.sound = .default()
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day], from: saveDate)
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
            center.add(request)
            
        } catch {
            
        }
        
    }
    
    @IBAction func deleteTitle() {
//        titleView.removeFromSuperview()
//        titleView.lastDrawImage = UIImage(named: "cellImg")
        titleView.lastDrawImage = nil
        titleView.path = nil
        titleView.setNeedsDisplay()
        // viewを更新
        titleView.layoutIfNeeded()
    }
    
    @IBAction func deleteMemo() {
//        memoView.removeFromSuperview()
//        memoView.lastDrawImage = UIImage(named: "cellImg")
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
