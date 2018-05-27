//
//  ViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/05/15.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import JTAppleCalendar
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    
    let formatter = DateFormatter()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var weekArray = ["SUN","MON","TUE","WED","THU","FRI","SAD"]
    var weekLabel: UILabel!
    
    let gray = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 0.4)
    
    var selectedDate: Date!
    var titleImage: UIImage!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバー
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navi"), for: .topAttached, barMetrics: .default)
        
        // 曜日ラベル
        for i in 0...6 {
            weekLabel = UILabel()
            let float: CGFloat = CGFloat(i)
            weekLabel.frame = CGRect(x: 375/7 * float,y: 115,width: 375/7,height: 50)
            weekLabel.backgroundColor = UIColor.clear
            weekLabel.textAlignment = .center
            weekLabel.text = weekArray[i]
            weekLabel.textColor = UIColor.white
            weekLabel.font = UIFont(name: "Dense", size: 23)
            self.view.addSubview(weekLabel)
        }
        
        // 予定追加するボタン
        let addSchedulesButton = UIButton()
        addSchedulesButton.frame = CGRect(x: 255, y: 540,width: 100, height: 100)
        addSchedulesButton.setImage(UIImage(named: "button"), for: UIControlState())
        addSchedulesButton.addTarget(self,action: #selector(ViewController.buttonTapped(sender:)),for: .touchUpInside)
        self.view.addSubview(addSchedulesButton)
        
        setupCalendarView()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 85
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewwill")
        tableView.reloadData()
    }
    
    // ボタンのイベント
    @objc func buttonTapped(sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "write") as! WriteSchedulesViewController
        self.present(nextView, animated: true, completion: nil)
    }
    
    // テーブルビュー
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        if selectedDate != nil {
            print("not nil")
            let title = realm.objects(realmDataSet.self).filter("date == %@", selectedDate)
            for i in title {
                titleImage = UIImage(data: i.title!)
            }
            cell.titleImageView.image = titleImage
        }
        
        return cell
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.backgroundColor = UIColor.clear
        
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendarView(from: visibleDates)
            }
    }
    
    func handleCellTextColor(view: JTAppleCell?,cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
        }else{
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.white
            }else{
                validCell.dateLabel.textColor = gray
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?,cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        }else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func setupViewsOfCalendarView(from visibleDates: DateSegmentInfo) {
            let date = visibleDates.monthDates.first!.date
            
            self.formatter.dateFormat = "yyyy"
            self.yearLabel.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMM"
            self.monthLabel.text = self.formatter.string(from: date)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        
        let parameters =  ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
}
    
    extension ViewController: JTAppleCalendarViewDelegate {
        func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
            let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            
            cell.dateLabel.text  = cellState.text
            
            handleCellSelected(view: cell, cellState: cellState)
            handleCellTextColor(view: cell, cellState: cellState)
            
            return cell
        }
        
        //  選択した日付
        func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            handleCellSelected(view: cell, cellState: cellState)
            handleCellTextColor(view: cell, cellState: cellState)
            selectedDate = date
            print("date is")
            print(date)
            print("selectedDate is")
            print(selectedDate)
            appDelegate.selectedDate = date
        }
        
        func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            handleCellSelected(view: cell, cellState: cellState)
            handleCellTextColor(view: cell, cellState: cellState)
        }
        
        func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
            let date = visibleDates.monthDates.first!.date
            
            formatter.dateFormat = "yyyy"
            yearLabel.text = formatter.string(from: date)
            
            formatter.dateFormat = "MMM"
            monthLabel.text = formatter.string(from: date)
            
        }
    
}
