//
//  TimeSettingViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/11.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class TimeSettingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    var timeTitleArray: [String] = ["前日19時","前日20時","前日21時","前日22時","前日23時","当日0時","当日5時","当日6時","当日7時","当日8時","当日9時","当日10時"]
    
    var timeArray: [Int] = [19,20,21,22,23,0,5,6,7,8,9,10]
    
    var saveTime = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
//        self.tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = timeTitleArray[indexPath.row]
        saveTime.set(timeArray[indexPath.row], forKey: "saveTime")
        if indexPath.row >= 5 {
            appdelegate.tomorrowBool = false
        }else{
            appdelegate.tomorrowBool = true
        }
        cell?.accessoryType = .checkmark
        return cell!
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
