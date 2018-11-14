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
import SideMenu

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var menuBarButton: UIBarButtonItem!
    @IBOutlet var bgImageView: UIImageView!
    
    let formatter = DateFormatter()
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var saveColor = UserDefaults.standard
    
    var weekArray = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    var weekLabel: UILabel!
    
//    var memoArray: [Data] = []
    
    let gray = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 0.4)
    
    var selectedDate: Date!
    var today = Date()
//    var titleImage: UIImage!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdid")

        // ナビゲーションバー
        
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Dense", size: 35)!]
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        SideMenuManager.default.menuPresentMode = .viewSlideInOut
//        SideMenuManager.default.menuFadeStatusBar = false
//        SideMenuManager.default.menuAlwaysAnimate = true
//
//        // 予定追加するボタン
//        let addSchedulesButton = UIButton()
//        // ビューのサイズからどのくらい離れてるかで描画する
//        addSchedulesButton.frame = CGRect(x: self.view.frame.width - 130, y: self.view.frame.height - 130,width: 100, height: 100)
//
//        if appDelegate.colorIndex == nil {
//            appDelegate.colorIndex = 0
//        }else{
//            appDelegate.colorIndex = saveColor.object(forKey: "Color") as? Int
//        }
//
//
//        for i in 0...6 {
//            if appDelegate.colorIndex == i {
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appDelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
//                bgImageView.image = UIImage(named: appDelegate.bgColorArray[i] + "BG")
//                addSchedulesButton.setImage(UIImage(named: appDelegate.bgColorArray[i] + "Button"), for: UIControlState())
//            }
//        }
//
//
//
//        addSchedulesButton.addTarget(self,action: #selector(ViewController.buttonTapped(sender:)),for: .touchUpInside)
//        self.view.addSubview(addSchedulesButton)
//
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.rowHeight = 85
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//
//        setupCalendarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // ナビゲーションバー
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Dense", size: 35)!]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAlwaysAnimate = true
        
        // 予定追加するボタン
        let addSchedulesButton = UIButton()
        // ビューのサイズからどのくらい離れてるかで描画する
        addSchedulesButton.frame = CGRect(x: self.view.frame.width - 130, y: self.view.frame.height - 130,width: 100, height: 100)
        
        if appDelegate.colorIndex == nil {
            appDelegate.colorIndex = 0
        }else{
            appDelegate.colorIndex = saveColor.object(forKey: "Color") as? Int
        }
        
        
        for i in 0...6 {
            if appDelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appDelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
                bgImageView.image = UIImage(named: appDelegate.bgColorArray[i] + "BG")
                addSchedulesButton.setImage(UIImage(named: appDelegate.bgColorArray[i] + "Button"), for: UIControlState())
            }
        }
        
        
        
        addSchedulesButton.addTarget(self,action: #selector(ViewController.buttonTapped(sender:)),for: .touchUpInside)
        self.view.addSubview(addSchedulesButton)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 85
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        setupCalendarView()
        
        print("viewwill呼ばれた")
        
        tableView.reloadData()
        calendarView.reloadData(withanchor: today)
    }
    
//    @IBAction func sideMenu() {
//         performSegue(withIdentifier: "LeftMenuNavigationController", sender: nil)
//    }
    
    // 新規作成ボタンのイベント
    @objc func buttonTapped(sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewController(withIdentifier: "write") as! WriteSchedulesViewController
        appDelegate.index = nil
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // テーブルビュー
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedDate != nil {
            let dataSet = realm.objects(realmDataSet.self).filter("date == %@", selectedDate).sorted(byKeyPath: "recordDate", ascending: true)
            return dataSet.count
        }else {
          return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        var titleArray: [Data] = []
        if selectedDate != nil {
            let dataSet = realm.objects(realmDataSet.self).filter("date == %@", selectedDate).sorted(byKeyPath: "recordDate", ascending: true)
            for i in dataSet {
                titleArray.append(i.title! as Data)
            }
            cell.titleImageView.image = UIImage(data: titleArray[indexPath.row] as Data)
        }
        return cell
    }
    
   // テーブルビューセルがタップされた時のメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.index = indexPath.row
        print("タップされたセルは\(String(describing: appDelegate.index))")
        performSegue(withIdentifier: "toWriteSchedules", sender: nil)
    }
    
    // セルの削除ボタン
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let deleteData = realm.objects(realmDataSet.self).filter("date == %@", selectedDate).sorted(byKeyPath: "recordDate", ascending: true)[indexPath.row]
            try! realm.write {
                realm.delete(deleteData)
            }
            self.tableView.reloadData()
            calendarView.reloadData(withanchor: today)
        }
    }
    
    // カレンダー関連
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.backgroundColor = UIColor.clear
        calendarView.selectDates([today])
        calendarView.reloadData(withanchor: today)
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
        }else{
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
        let endDate = formatter.date(from: "2019 12 31")
        
        let parameters =  ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
}

extension ViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            
        cell.dateLabel.text  = cellState.text
            
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        
        if date == today {
            cell.selectedView.isHidden = false
        }
        
        let dataSet = self.realm.objects(realmDataSet.self).filter("date == %@", date).sorted(byKeyPath: "recordDate", ascending: true)
                    if dataSet.count >= 1 {
                        cell.markView.isHidden = false
                    }else if dataSet.count == 0 {
                        cell.markView.isHidden = true
                    }
        
        return cell
    }
    
    //  選択した日付
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        selectedDate = date
        tableView.reloadData()
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
