//
//  NotificationUIViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/11.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import SideMenu

class NotificationUIViewController: UIViewController {
    
    let borderColor = UIColor(red: 0.207, green: 0.207, blue: 0.207, alpha: 1.0)
    let tintColor = UIColor(red: 0.313, green: 0.662, blue: 0.945, alpha: 1.0)
    
    @IBOutlet var notificationView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var uiSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        
        writeBorder()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navi"), for: .topAttached, barMetrics: .default)
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAlwaysAnimate = true
        
        uiSwitch.onTintColor = tintColor

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
