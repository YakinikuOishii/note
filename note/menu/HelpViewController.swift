//
//  HelpViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/12.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let appdelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Dense", size: 20)!]
        for i in 0...6 {
            if appdelegate.colorIndex == i {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: appdelegate.bgColorArray[i]), for: .topAttached, barMetrics: .default)
            }
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else if section == 1 {
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear // 透明にすることでスペースとする
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 0.5
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = "Gmail"
            }else if indexPath.row == 1 {
                cell?.textLabel?.text = "Twitter"
            }
            
        }else if indexPath.section == 1 {
            cell?.textLabel?.text = "使い方"
        }else{
            
        }
        

        return cell!
    }
    
    // テーブルビューセルがタップされた時のメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section is \(indexPath.section)")
        print("index is \(indexPath.row)")
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
//                let url = URL(string: "https://twitter.com/SPEEDAY1?lang=ja")!
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url)
//                }
                let title = "開発中の機能です"
                let message = "アップデートをお待ちください"
                let close = "閉じる"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let closeButton = UIAlertAction(title: close, style: .cancel, handler: nil)
                alert.addAction(closeButton)
                
                present(alert, animated: true, completion: nil)
            }else if indexPath.row == 1 {
                let url = URL(string: "https://twitter.com/SPEEDAY1?lang=ja")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }else if indexPath.section == 1 {
            performSegue(withIdentifier: "toHowTo", sender: nil)
        }
        
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
