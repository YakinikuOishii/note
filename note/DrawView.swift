//
//  DrawView.swift
//  note
//
//  Created by 笠原未来 on 2018/05/21.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class DrawView: UIView {
//    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var penColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    var penSize: CGFloat = 6.0
    
    private var path: UIBezierPath!
    private var lastDrawImage: UIImage!
    
    override func draw(_ rect: CGRect) {
        lastDrawImage?.draw(at: CGPoint.zero)
        penColor.setStroke()
        path?.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint = touches.first!.location(in: self)
        path = UIBezierPath()
        path?.lineWidth = penSize
        path?.lineCapStyle = CGLineCap.round
        path?.lineJoinStyle = CGLineJoin.round
        path?.move(to: currentPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint = touches.first!.location(in: self)
        path?.addLine(to: currentPoint)
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint = touches.first!.location(in: self)
        path.addLine(to: currentPoint)
        lastDrawImage = snapShot()
        setNeedsDisplay()
    }
    
    func snapShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        lastDrawImage?.draw(at: CGPoint.zero)
        penColor.setStroke()
        path?.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
//    func borderColor() {
//        self.layer.borderColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1.0) as! CGColor
//    }

}
