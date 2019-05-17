//
//  HLLTransitoonViewController.swift
//  CoreAnimation
//
//  Created by  bochb on 2019/4/12.
//  Copyright © 2019 boc. All rights reserved.
//

import UIKit

class HLLTransitoonViewController: UIViewController {

    let layer: CALayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        let btn = UIButton(frame: CGRect(x: 10, y: 144, width: 200, height: 44))
        btn.setTitle("begin transitoon", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
        
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.position = view.center
        layer.backgroundColor = UIColor.yellow.cgColor
        view.layer.addSublayer(layer)
    }
    

    
    @objc func btnAction(){

        changeBackgroundColor()
        changeLayerColor()
    }
    
    
    /*
     使用步骤:
     
     1. 创建CATransition动画实例
     2. 设置相关动画属性
     3. 将动画添加到需要做动画的图层中
     4. 动画的图层改变背景都会带动画
     
     */
    func changeLayerColor() -> Void {
        let trans = CATransition()
        //主要种类，决定动画效果
        trans.type = kCATransitionFade
        //次要种类，决定动画方向, 有上下左右四个方向
//        trans.subtype = kCATransitionFromTop
        //动画开始的位置,起始位置为0
        trans.startProgress = 0.1
        //动画j结束位置, 终点位置为1
        trans.endProgress = 0.8
        //动画的时间函数
        trans.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        //设置动画时长
        trans.duration = 3
        //给需要动画的图层添加动画
        layer.add(trans, forKey: "animationName")
        //改变图层的属性, 那么就会自带动画
        layer.backgroundColor = UIColor.randomColor().cgColor
    }
    //改变背景颜色
    func changeBackgroundColor() -> Void {
        let trans = CATransition()
        trans.type = kCATransitionFade
        trans.subtype = kCATransitionFromTop
        view.layer.add(trans, forKey: "animationName")
        view.backgroundColor = UIColor.randomColor()
    }
}
