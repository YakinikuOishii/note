//
//  NotificationUIViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/11.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class NotificationUIViewController: UIViewController {
    
    let borderColor = UIColor(red: 0.207, green: 0.207, blue: 0.207, alpha: 1.0)
    let tintColor = UIColor(red: 0.313, green: 0.662, blue: 0.945, alpha: 1.0)
    
    @IBOutlet var notificationView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var uiSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationView.layer.borderColor = borderColor.cgColor
        timeView.layer.borderColor = borderColor.cgColor
        notificationView.layer.borderWidth = 1.0
        timeView.layer.borderWidth = 1.0
        
        uiSwitch.onTintColor = tintColor

        // Do any additional setup after loading the view.
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
