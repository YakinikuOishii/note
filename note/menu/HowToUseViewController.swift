//
//  HowToUseViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/16.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController {
    
    let borderColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.0)
    
    var appdelegate: AppDelegate! = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet var calenderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        
        calenderButton.layer.borderColor = borderColor.cgColor
        calenderButton.layer.borderWidth = 1.5

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
