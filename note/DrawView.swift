//
//  DrawView.swift
//  note
//
//  Created by 笠原未来 on 2018/05/21.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class DrawView: UIView {

    
    var penColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    var penSize: CGFloat = 6.0
    
    var path: UIBezierPath!
    var lastDrawImage: UIImage!
    
    var editMode: Bool = true
    
    var canvas = UIImageView()
    
//    override func draw(_ rect: CGRect) {
//        lastDrawImage?.draw(at: CGPoint.zero)
//        penColor.setStroke()
//        path?.stroke()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        canvas.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        canvas.backgroundColor = .clear
        self.addSubview(canvas)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == true {
            let currentPoint = touches.first!.location(in: self)
            path = UIBezierPath()
            path?.lineWidth = penSize
            path?.lineCapStyle = CGLineCap.round
            path?.lineJoinStyle = CGLineJoin.round
            path?.move(to: currentPoint)
        }else{

        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == true {
            let currentPoint = touches.first!.location(in: self)
            path?.addLine(to: currentPoint)
            drawLine(path: path)
        }else{

        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == true {
            let currentPoint = touches.first!.location(in: self)
            path.addLine(to: currentPoint)
            drawLine(path: path)
            lastDrawImage = canvas.image

        }else{

        }
        
    }
    
    func drawLine(path: UIBezierPath) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        penColor.setStroke()
        path.stroke()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func snapShot() -> UIImage {
        // スクリーンショットを取得
        UIGraphicsBeginImageContext(bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    


}
