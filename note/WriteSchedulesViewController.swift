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
    
    var today: Date!
    
    var titleData: NSData!
    var timeData: NSData!
    var memoData: NSData!
    
    var titleImage: UIImage!
    var timeImage: UIImage!
    var memoImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        today = appDelegate.today
        
    }
    
    @IBAction func saveSchedules() {
        let realm = try! Realm()
        let dataSet = realmDataSet()
        dataSet.date = today
        
        viewWithTag(1)
        viewWithTag(2)
        viewWithTag(3)
        
        titleData = UIImagePNGRepresentation(titleImage)! as NSData
        timeData = UIImagePNGRepresentation(timeImage)! as NSData
        memoData = UIImagePNGRepresentation(memoImage)! as NSData
        
        dataSet.title = titleData! as Data
        dataSet.time = timeData! as Data
        dataSet.memo = memoData! as Data
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewWithTag(_ tag: Int) -> UIView? {
        if tag == 1 {
            titleImage = drawView.snapShot()
//            titleData = UIImagePNGRepresentation(titleImage)! as NSData
        }else if tag == 2 {
            timeImage = drawView.snapShot()
//            timeData = UIImagePNGRepresentation(timeImage)! as NSData
        }else if tag == 3 {
            memoImage = drawView.snapShot()
//            memoData = UIImagePNGRepresentation(memoImage)! as NSData
        }
        return view
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
