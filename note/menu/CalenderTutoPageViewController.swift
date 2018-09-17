//
//  CalenderTutoPageViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/09/18.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

struct PageSettings {
    static let idList = ["tuto1", "tuto2", "tuto3","tuto4"]
    
    static func generateViewControllerList() -> [UIViewController] {
        var viewControllers : [UIViewController] = []
        self.idList.forEach{ viewControllerName in
            let viewController = UIStoryboard(name: "Main", bundle: nil) . instantiateViewController(withIdentifier: "\(viewControllerName)")
            
            viewControllers.append(viewController)
        }
        return viewControllers
    }
}

class CalenderTutoPageViewController: UIPageViewController{
    
    var pageControl: UIPageControl!
    var viewControllerIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([PageSettings.generateViewControllerList().first!], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    //ページコントロールの最初の位置を返すメソッド
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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

extension CalenderTutoPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let targetViewControllers : [UIViewController] = PageSettings.generateViewControllerList()
        
        if viewControllerIndex == targetViewControllers.count - 1 {
            return nil
        } else {
            viewControllerIndex = viewControllerIndex + 1
        }
        
        return targetViewControllers[viewControllerIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let targetViewControllers : [UIViewController] = PageSettings.generateViewControllerList()
        
        if viewControllerIndex == 0 {
            return nil
        } else {
            viewControllerIndex = viewControllerIndex - 1
        }
        
        return targetViewControllers[viewControllerIndex]
    }
    
}
