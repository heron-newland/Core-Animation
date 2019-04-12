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
    

    /*
     自定义了一个行为，不论在什么时候改变背景颜色，新的色块都是从左侧滑入，而不是默认的渐变效果。（CATransition是一个动画(一般完成过渡动画),而CATransaction是一个动画事务）
     */
    @objc func btnAction(){
        //uiview默认关闭隐式动画, 可以打开下面两行代码对比一下效果
//        layer.backgroundColor = UIColor.red.cgColor
//        view.backgroundColor = UIColor.green
      
        let trans = CATransition()
        trans.type = kCATransitionReveal
        trans.subtype = kCATransitionFromRight
//        trans.duration = 2
//        layer.actions = ["backgroundColor":trans]
        layer.add(trans, forKey: nil)
    }
}
