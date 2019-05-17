//
//  HLLCAEmitterLayerController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/18.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class HLLCAEmitterLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.bounds = view.bounds;
        emitterLayer.position = view.center
        emitterLayer.masksToBounds = true
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width * 0.5, y: -20)
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterMode = kCAEmitterLayerSurface
        emitterLayer.emitterSize = view.bounds.size
        emitterLayer.emitterCells = setEmitterCells()
        view.layer.addSublayer(emitterLayer)
    }

    
    func setEmitterCells() -> [CAEmitterCell]{
        let rainCell = CAEmitterCell()
        
        //产生粒子的速度, 实际产生的个数与speed属性相关
        rainCell.birthRate = 1
        
        //实际时间的倍数, 例如 rainCell.speed = 100就是 100 对应 1s, 影响粒子的生命周期, 以及所有与速度相关的属性, 实际速度 = speed * 给定的值. 例如 rainCell.birthRate = 1 , 那么每秒钟实际产生的粒子数量为 1 * 10 = 10ge
        rainCell.speed = 10
        
        //粒子的生命周期, 以秒为单位, 换成绝对秒的公式为rainCell.lifetime /   rainCell.speed, 比如 rainCell.lifetime = 200,rainCell.speed = 100, 那么例子的实际生命周期只有200 / 100 = 2s
        rainCell.lifetime = 200
        
        //粒子初速度
        rainCell.velocity = 0
        rainCell.velocityRange = 110
        
        //缩放因子
        rainCell.scaleSpeed = 0.4
        rainCell.scale = 0.5
        rainCell.scaleRange = 0.5
        
        //x,y,z方向上的加速度
        rainCell.yAcceleration = 80
        rainCell.xAcceleration = 20
        rainCell.zAcceleration = 60
        
        rainCell.color = UIColor.red.cgColor
        rainCell.contents = UIImage(named: "more_dot")?.cgImage
        return [rainCell]
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
