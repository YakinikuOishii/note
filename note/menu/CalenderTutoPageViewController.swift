//
//  CalenderTutoPageViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/18.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class CalenderTutoPageViewController: UIPageViewController{
    
    let idList = ["tuto1", "tuto2", "tuto3", "tuto4"]
    
    override func viewDidLoad() {
        
        //最初のビューコントローラーを取得する。
        let controller = storyboard!.instantiateViewController(withIdentifier: idList.first!)
        
        //ビューコントローラーを表示する。
        self.setViewControllers([controller], direction: .forward, animated: true, completion:nil)
        
        //データ提供元に自分を設定する。
//        self.dataSource = self
        
        //全ページ数を返すメソッド
        func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
            return idList.count
        }
        
        //ページコントロールの最初の位置を返すメソッド
        func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
            return 0
        }
    }
    
    
    
    //右ドラッグ時の呼び出しメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //現在のビューコントローラーのインデックス番号を取得する。
//        let index = idList.indexOf(viewController.restorationIdentifier!)!
        let index = idList.index(of: viewController.restorationIdentifier!)!
        if (index > 0) {
            //前ページのビューコントローラーを返す。
            return storyboard!.instantiateViewController(withIdentifier: idList[index-1])
        }
        return nil
    }
    
    
    
    //左ドラッグ時の呼び出しメソッド
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        //現在のビューコントローラーのインデックス番号を取得する。
        let index = idList.index(of: viewController.restorationIdentifier!)!
        if (index < idList.count-1) {
            //次ページのビューコントローラーを返す。
            return storyboard!.instantiateViewController(withIdentifier: idList[index+1])
        }
        return nil
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
