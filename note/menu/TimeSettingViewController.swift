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
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var backButton: UIBarButtonItem!
    
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as? AppDelegate
    
    var timeNameArray: [String] = ["前日19時","前日20時","前日21時","前日22時","前日23時","当日0時","当日5時","当日6時","当日7時","当日8時","当日9時","当日10時"]
    var timeArray: [Int] = [19,20,21,22,23,0,5,6,7,8,9,10]
    
    var selectedTime: Int!
    var selectedName: String!
    
    var saveTime = UserDefaults.standard
    var saveName = UserDefaults.standard

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsMultipleSelection = false

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        selectedTime = timeArray[indexPath.row]
        selectedName = timeNameArray[indexPath.row]
        print(indexPath.row)
        cell?.accessoryType = .checkmark
    }
    //
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // チェックマークを外す
        cell?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = timeNameArray[indexPath.row]
        if indexPath.row >= 5 {
            appdelegate.tomorrowBool = false
        }else{
            appdelegate.tomorrowBool = true
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    @IBAction func save() {
        saveTime.removeObject(forKey: "saveTime")
        saveName.removeObject(forKey: "saveName")
        saveTime.set(selectedTime, forKey: "saveTime")
        saveName.set(selectedName, forKey: "saveName")
        dismiss(animated: true, completion:nil)
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
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
