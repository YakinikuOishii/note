//
//  ViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/05/15.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    let formatter = DateFormatter()
    
    var weekArray = ["SUN","MON","TUE","WED","THU","FRI","SAD"]
    var weekLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bg"), for: .topAttached, barMetrics: .default)
        
        for i in 0...6 {
            weekLabel = UILabel()
            let float: CGFloat = CGFloat(i)
            weekLabel.frame = CGRect(x: 375/7 * float,y: 115,width: 375/7,height: 50)
            weekLabel.backgroundColor = UIColor.clear
            weekLabel.textAlignment = .center
            weekLabel.text = weekArray[i]
            weekLabel.textColor = UIColor.white
            self.view.addSubview(weekLabel)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters =  ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text  = cellState.text
        return cell
    }
    
    
}
