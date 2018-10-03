//
//  CarouselViewController.swift
//  note
//
//  Created by 笠原未来 on 2018/10/04.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController {
    
    var carouselView:CarouselView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        carouselView.scrollToFirstItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        carouselView = CarouselView(frame: CGRect(x:0, y:0, width:width, height:height))
        carouselView.center = CGPoint(x:width / 2,y: height / 2)
        self.view.addSubview(carouselView)

        // Do any additional setup after loading the view.
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
