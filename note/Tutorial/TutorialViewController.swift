//
//  TutorialViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/10/22.
//  Copyright © 2018 笠原未来. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: FourthViewController.self) {
            return getThird()
            
        } else if viewController.isKind(of: ThirdViewController.self) {
            return getSecond()
            
        } else if viewController.isKind(of: SecondViewController.self){
            return getThird()
            
        }else{
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: FirstViewController.self) {
            return getSecond()
            
        } else if viewController.isKind(of: SecondViewController.self) {
            return getThird()
            
        } else if viewController.isKind(of: ThirdViewController.self) {
            return getFourth()
            
        }else {
            return nil
        }

    }
    
    func getFirst() -> FirstViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }
    
    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
    func getFourth() -> FourthViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
    }

}
extension TutorialViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: ThirdViewController.self) {
            // 3 -> 2
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: FirstViewController.self) {
            // 1 -> 2
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            // 2 -> 3
            return getThird()
        } else {
            // 3 -> end of the road
            return nil
        }
    }
    
}
