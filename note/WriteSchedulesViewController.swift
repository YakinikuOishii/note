//
//  WriteSchedulesViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/05/20.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class WriteSchedulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navi"), for: .topAttached, barMetrics: .default)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSchedules() {
        dismiss(animated: true, completion: nil)
//        self.performSegue(withIdentifier: "toViewController", sender: (Any).self)
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
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
