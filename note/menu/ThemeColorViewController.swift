//
//  ThemeColorViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/12.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import SideMenu

class ThemeColorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let colorNameArray: [String] = ["ブルー","グリーン","オレンジ","レッド","ピンク","パープル","ネイビー"]
    let bgColorArray: [String] = ["blue","green","orange","red","pink","purple","black"]
    
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as? AppDelegate
    
    var saveColor = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        SideMenuManager.default.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAlwaysAnimate = true
        
//        if appdelegate.colorIndex != nil {
//            appdelegate.colorIndex = saveColor.object(forKey: "color") as? Int
//        }else{
//
//        }
        
        
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.allowsMultipleSelection = false

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return colorNameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // セルの上部のスペース
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = colorNameArray[indexPath.section]
        cell?.textLabel?.textColor = UIColor.white
        
        let cellImage = UIImageView()
        cellImage.image = UIImage(named: bgColorArray[indexPath.section])
        cellImage.contentMode = .scaleToFill
        cell?.backgroundView = cellImage
        return cell!
    }
    
    // テーブルビューセルがタップされた時のメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        print(colorNameArray[indexPath.section])
        
        tableView.deselectRow(at: indexPath, animated: false)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        saveColor.removeObject(forKey: "color")
        
        for i in 0...6 {
            if indexPath.section == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: bgColorArray[i]), for: .topAttached, barMetrics: .default)
                appdelegate.colorIndex = i
//                saveColor.set(i, forKey: "color")
            }else{
                
            }
        }
        
        saveColor.set(appdelegate.colorIndex, forKey: "Color")
        print(saveColor)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none

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
