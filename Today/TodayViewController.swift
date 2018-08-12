//
//  TodayViewController.swift
//  Today
//
//  Created by 笠原未来 on 2018/07/17.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var titleImageView: UIImageView!

    var dateArray: [Date?] = []
    var titleArray: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleArray != nil {
            print("空じゃない")
            getData()
            titleImageView.image = UIImage(data: titleArray[0])
        }else{
            print("空っぽ")
            titleImageView.image = UIImage(named: "cellImg.png")
        }
        
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func tappedImage(_ sender: UIImageView) {
        guard let url = URL(string: "note://") else { return }
        extensionContext?.open(url, completionHandler: { (success: Bool) in })
    }
    
    func getData () {
        let defaults = UserDefaults(suiteName: "group.com.litech.note")
        let titleImage = defaults!.object(forKey: "title") as? Data
        let date = defaults!.object(forKey: "date") as? Date
        
        dateArray.append(date!)
        titleArray.append(titleImage!)
        
//        try! realm.write {
//            let appdateData = realm.objects(realmDataSet.self).filter("date == %@", date!)
//            appdateData.
//            realm.add(date)
//        }
        
    }
    
}
