//
//  HLLCAReplicatorLayerController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/19.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class HLLCAReplicatorLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
//        basicUsage()
       
        rotateCircle()
        
    }

    /* 使用步骤
     *  一,创建 CAReplicatorLayer 设置相关属性, 并添加到父 layer
     *  二,创建将要被复制的layer, 设置先关属性, 并添加到 CAReplicatorLayer 图层中
     *  三,设置动画等, 并添加到被复制的layer中
     
     CAReplicatorLayer属性
     ** instanceDelay   被复制的图层动画延时, 没有动画此属性无效
     
     ** instanceBlueOffset,instanceRedOffset, instanceGreenOffset, instanceAlphaOffset  设置颜色和透明度通道的偏移, 在原来的颜色通道的基础上进行加减, >1或者<0之后不会变化. 所以需要根据原色的通道值的大小决定是正向偏移还是负向偏移
     
     **
     */
    
    func rotateCircle() {
        let replicator = CAReplicatorLayer()
        replicator.bounds = view.bounds
        replicator.position = view.center
        replicator.instanceCount = 12
        replicator.instanceDelay = 0.4
        replicator.preservesDepth = true
        //设置
//        replicator.instanceColor = UIColor.randomColor().cgColor
        //设置颜色通道的偏移, 在原来的颜色通道的基础上进行加减, >1或者<0之后不会变化. 所以需要根据原色的通道值的大小决定是正向偏移还是负向偏移
        replicator.instanceBlueOffset = -1.0 / 6.0
//        replicator.instanceRedOffset = -1.0 / 6.0
//        replicator.instanceGreenOffset = -1.0 / 6.0
        //透明度逐渐降低
        replicator.instanceAlphaOffset = -1.0 / Float(replicator.instanceCount)
        
        let transform = CATransform3DIdentity
        
        //绕Z轴旋转赋值图层
        replicator.instanceTransform = CATransform3DRotate(transform, CGFloat.pi * 2.0 / CGFloat(replicator.instanceCount), 0, 0, 1)
        view.layer.addSublayer(replicator)
        
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        layer.position = CGPoint(x: view.center.x + 100.0, y: view.center.y)
        layer.cornerRadius = 20
        layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        replicator.addSublayer(layer)
        
//        let shape = CAShapeLayer()
//        let path = CGMutablePath()
//        path.addArc(center: CGPoint(x: view.center.x + 100.0, y: view.center.y), radius: 20, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
//        shape.path = path
//        shape.fillColor = UIColor.randomColor().cgColor
//        replicator.addSublayer(shape)
        
        let anim = CABasicAnimation(keyPath: "transform.scale")
       
        anim.duration = 0.5
        anim.fromValue = 1
        anim.toValue = 0.5
        anim.repeatCount = MAXFLOAT
        //设置为true那么放大2s, 缩小为原来的大小2s,设置为false,那么放大2s, 缩小为原来的大小0s
        anim.autoreverses = true
        layer.add(anim, forKey: "scaleAnim")
    }
    
    /// 音律跳动Demo
    func basicUsage() -> Void {
        
        //创建CAReplicatorLayer
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = view.bounds
        replicatorLayer.position = view.center
        replicatorLayer.backgroundColor = UIColor.yellow.cgColor
        view.layer.addSublayer(replicatorLayer)
        replicatorLayer.instanceCount = 8
        replicatorLayer.instanceDelay = 0.5//动画延迟
        replicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 50, 0, 0)
        
        //创建被复制的shapeLayer
//        let shapeLayer = CAShapeLayer()
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 20, y: 200))
//        path.addLine(to: CGPoint(x: 20, y: 300))
//        shapeLayer.path = path
//        shapeLayer.lineWidth = 30
//        shapeLayer.strokeColor = UIColor.randomColor().cgColor
//        replicatorLayer.addSublayer(shapeLayer)
        
        //或者创建被复制的layer
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 10, height: 60)
        layer.position = CGPoint(x: 10, y: view.center.y)
        layer.backgroundColor = UIColor.randomColor().cgColor
        replicatorLayer.addSublayer(layer)
        
        //设置layer的动画
        let ani = CABasicAnimation(keyPath: "transform.scale.y")
        ani.duration = 0.5
//        ani.fromValue = 0.5
        ani.toValue = 0.1
        ani.autoreverses = true
        ani.repeatCount = MAXFLOAT
        layer.add(ani, forKey: "jumpAnimation")
        
        
        
        
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
