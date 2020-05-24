//
//  TopSelectBarCircleMarkView.swift
//  HSCMTopSelectBar
//
//  Created by Cimons on 2020/5/18.
//  Copyright © 2020 Cimons. All rights reserved.
//

import UIKit

class TopSelectBarCircleMarkView: UIView {

    var colorStroke: UIColor = UIColor(red: 168/255.0, green: 171/255.0, blue: 180/255.0, alpha: 1.0){
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
                
        colorStroke.setStroke()
        let aPath = UIBezierPath(arcCenter: CGPoint(x: 6, y: 6), radius: 4.5,
                    startAngle: 0, endAngle: CGFloat(Double.pi)*2, clockwise: true)
        aPath.close()
        aPath.lineWidth = 3.0 // 线条宽度
        aPath.stroke() // Draws line 根据坐标点连线，不填充
//        aPath.fill() // Draws line 根据坐标点连线，填充
    }

}
