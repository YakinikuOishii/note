//
//  WriteSchedulesViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/05/20.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import RealmSwift

class WriteSchedulesViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let drawView = DrawView()
    let realm = try! Realm()
    let dataSet = realmDataSet()
    
    var selectedDate: Date!
    var index: Int!
    
    @IBOutlet var titleView: DrawView!
    @IBOutlet var memoView: DrawView!
    
    var titleData: NSData!
    var memoData: NSData!
    var titleImage: UIImage!
    var memoImage: UIImage!
    
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
            print("indexは空だよ")
        }
        
    }
    
    @IBAction func saveSchedules() {
        titleRepresentation()
        memoRepresentation()
        
        dataSet.date = selectedDate
        dataSet.title = titleData! as Data
        dataSet.memo = memoData! as Data
        
        save()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(dataSet)
            }
        } catch {
            
        }
        
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
