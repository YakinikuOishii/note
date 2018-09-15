//
//  NotificationUIViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/11.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import AudioToolbox

class NotificationUIViewController: UIViewController{
    
    let borderColor = UIColor(red: 0.207, green: 0.207, blue: 0.207, alpha: 1.0)
    let blue = UIColor(red: 0.313, green: 0.662, blue: 0.945, alpha: 1.0)
    let green = UIColor(red: 0.145, green: 0.772, blue: 0.521, alpha: 1.0)
    let orange = UIColor(red: 1.0, green: 0.709, blue: 0.168, alpha: 1.0)
    let red = UIColor(red: 0.913, green: 0.317, blue: 0.301, alpha: 1.0)
    let pink = UIColor(red: 0.890, green: 0.417, blue: 0.596, alpha: 1.0)
    let purple = UIColor(red: 0.823, green: 0.0, blue: 1.0, alpha: 1.0)
    let black = UIColor(red: 0.160, green: 0.152, blue: 0.309, alpha: 1.0)
    
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
//    let dataList :[String] = ["00:00","06:00","12:00","15:00","20:00"]
    
    @IBOutlet var notificationView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var uiSwitch: UISwitch!
//    @IBOutlet var label: UILabel!
//    @IBOutlet var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        
        writeBorder()
        
        tintColor()
        uiSwitch.addTarget(self, action: #selector(NotificationUIViewController.switchClick(sender:)), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
    }
    
    func writeBorder() {
        
        let topBorderN = CALayer()
        topBorderN.frame = CGRect(x: 0, y: 0, width: notificationView.frame.width, height: 1.0)
        topBorderN.backgroundColor = UIColor.lightGray.cgColor
        notificationView.layer.addSublayer(topBorderN)
        
        let topBorderT = CALayer()
        topBorderT.frame = CGRect(x: 0, y: 0, width: timeView.frame.width, height: 1.0)
        topBorderT.backgroundColor = UIColor.lightGray.cgColor
        timeView.layer.addSublayer(topBorderT)
        
        let underBorderN = CALayer()
        underBorderN.frame = CGRect(x: 0, y: self.notificationView.frame.height - underBorderN.frame.height, width: notificationView.frame.width, height: 1.0)
        underBorderN.backgroundColor = UIColor.lightGray.cgColor
        notificationView.layer.addSublayer(underBorderN)
        
        let underBorderT = CALayer()
        underBorderT.frame = CGRect(x: 0, y: self.timeView.frame.height - underBorderT.frame.height, width: timeView.frame.width, height: 1.0)
        underBorderT.backgroundColor = UIColor.lightGray.cgColor
        timeView.layer.addSublayer(underBorderT)
        
    }
    
    func tintColor() {
        if appdelegate.colorIndex == 0 {
            uiSwitch.onTintColor = blue
        }else if appdelegate.colorIndex == 1 {
            uiSwitch.onTintColor = green
        }else if appdelegate.colorIndex == 2 {
           uiSwitch.onTintColor = orange
        }else if appdelegate.colorIndex == 3 {
            uiSwitch.onTintColor = red
        }else if appdelegate.colorIndex == 4 {
            uiSwitch.onTintColor = pink
        }else if appdelegate.colorIndex == 5 {
            uiSwitch.onTintColor = purple
        }else if appdelegate.colorIndex == 6 {
            uiSwitch.onTintColor = black
        }else{
            uiSwitch.onTintColor = blue
        }
    }
    
    @objc func switchClick(sender: UISwitch){
        
        if sender.isOn {
            AudioServicesPlaySystemSound(1003);
            AudioServicesDisposeSystemSoundID(1003);
            print("On")
        }else {
            print("Off")
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
