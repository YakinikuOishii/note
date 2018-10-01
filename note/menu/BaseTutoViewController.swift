//
//  BaseTutoViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/18.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class BaseTutoViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    
    let borderColor = UIColor(red: 0.133, green: 0.654, blue: 0.945, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.borderColor = borderColor.cgColor

    }
    
    @IBAction func skip() {
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
