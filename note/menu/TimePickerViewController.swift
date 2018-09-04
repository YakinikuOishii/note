//
//  TimePickerViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/04.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var pickerView: UIPickerView!
    
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    
    let minutesArray :[String] = ["00","10","20","30","40","50"]
    let hoursArray: [String] = ["00",
                                "01",
                                "02",
                                "03",
                                "04",
                                "05",
                                "06",
                                "07",
                                "08",
                                "09",
                                "10",
                                "11",
                                "12",
                                "13",
                                "14",
                                "15",
                                "16",
                                "17",
                                "18",
                                "19",
                                "20",
                                "21",
                                "22",
                                "23",
                                "24",]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        
        pickerView.reloadAllComponents()
    }
    
//     UIPickerViewの列の数
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
    
        // UIPickerViewの行数、リストの数
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            if component == 0 {
                return hoursArray.count
            }else if component == 1 {
                return minutesArray.count

            }else{
               return 1
            }
                    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 表示するラベルを生成する
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
//        label.font = UIFont(name: "Yu Gothic",size:50)
        label.textAlignment = .center
        if component == 0 {
            label.text = hoursArray[row]
            label.font = UIFont(name: "Yu Gothic",size:70)
        }else if component == 1 {
            label.text = minutesArray[row]
            label.font = UIFont(name: "Yu Gothic",size:70)
        }else{
            
        }
        return label
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0 {
            return String(hoursArray[0])
        }else if component == 1 {
            return String(minutesArray[0])
            
        }else{
            return "error"
        }
    }
    
        // UIPickerViewのRowが選択された時の挙動
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            print(component)
            print(row)
    
    //        label.text = dataList[row]
    
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
