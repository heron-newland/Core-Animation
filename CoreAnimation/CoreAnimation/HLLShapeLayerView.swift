//
//  HLLShapeLayerView.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/18.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class HLLShapeLayerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let ctx = UIGraphicsGetCurrentContext()
        let path = CGPath(rect: CGRect(x: 20, y: 100, width: 300, height: 50), transform: nil)
        ctx?.addPath(path)
        ctx?.setLineJoin(.round)
        ctx?.setLineCap(.round)
        ctx?.setLineWidth(5)
        ctx?.setStrokeColor(UIColor.red.cgColor)
        ctx?.strokePath()
        
        let roundPath = CGPath(roundedRect: CGRect(x: 20, y: 200, width: 300, height: 100), cornerWidth: 20, cornerHeight: 20, transform: nil)
        ctx?.addPath(roundPath)
        ctx?.setLineWidth(6)
        ctx?.setStrokeColor(UIColor.gray.cgColor)
        ctx?.setLineDash(phase: 3, lengths: [3,6,3])
        ctx?.strokePath()
    }
    
}
