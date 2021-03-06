//
//  RootTableViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/08/11.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController{
    
    let settingArray: [String] = ["通知","テーマ"]
    let otherArray: [String] = ["ヘルプ","使い方","レビュー"]
    
    let sectionArray: [String] = ["","設定","その他"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else if section == 1 {
            return settingArray.count
            
        }else if section == 2{
            return otherArray.count
        }else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "ホーム"
        }else if indexPath.section == 1 {
            cell.textLabel?.text = settingArray[indexPath.row]
        }else if indexPath.section == 2 {
            cell.textLabel?.text = otherArray[indexPath.row]
        }
        return cell
        
    }
    
//     セルがタップされた時のメソッド
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "toHome", sender: nil)
        }else if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                performSegue(withIdentifier: "toNotification", sender: nil)
            }else if indexPath.row == 1 {
                performSegue(withIdentifier: "toThemeColor", sender: nil)
            }else{
                
            }
            
        }else if indexPath.section == 2 {
            
            if indexPath.row == 0 {
                performSegue(withIdentifier: "toHelp", sender: nil)
            }else if indexPath.row == 1 {
                performSegue(withIdentifier: "toHowTo", sender: nil)
            }else if indexPath.row == 2 {
                if let url = URL(string: "https://itunes.apple.com/jp/app/speeday/id1439199775?l=en&mt=8") {
                    UIApplication.shared.open(url)
                }
                //飛べない？
            }else{
                
            }
        }
        
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
