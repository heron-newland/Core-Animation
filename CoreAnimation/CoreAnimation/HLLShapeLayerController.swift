//
//  HLLShapeLayerController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/18.
//  Copyright © 2017年 boc. All rights reserved.
//

/*
 *  miterLimit 最大斜接长度， 当 lineJoin 属性设置为 kCALineJoinMiter生效。例如 → 很长时， 箭头部分很长， 可以通过miterLimit设置箭头的最大长度， 多余的会被切掉
 
 *  lineDashPhase   虚线的起始位置， 可以设置一个滚动的虚线框
 
 *  strokeStart、strokeEnd 渲染路径的起点和终点， 取值范围为 0~1.
 
 *
 */
import UIKit

class HLLShapeLayerController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        //        let shapeLayer1 = HLLShapeLayerView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 350))
        //        view.addSubview(shapeLayer1)
        let button = UIButton(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width, height: 44))
        button.setTitle("linedash animation", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        let button1 = UIButton(frame: CGRect(x: 0, y: 140, width: UIScreen.main.bounds.size.width, height: 44))
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("touch screen to show wave animation", for: .normal)
        button1.tag = 2
        button1.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        view.addSubview(button1)
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton){
        if sender.tag == 1 {
            view.layer.contents = UIImage().cgImage
            view.layer.contentsScale = UIScreen.main.scale
            dashAnimation()
        }
        if sender.tag == 2 {
            view.layer.contents = UIImage(named: "homePage")?.cgImage
            view.layer.contentsScale = UIScreen.main.scale
        }
    }
    var index:Int = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        index += 1
        //获取当前点击位置
        let touch = touches.first
        let currentLocation = touch?.location(in: view)
        //取屏幕宽高的平方根
        let radius = sqrt(pow(UIScreen.main.bounds.size.width, 2) + pow(UIScreen.main.bounds.size.height, 2))
        
        touchToChangeBackgoundImage(location: currentLocation!, radius: radius, animationDuration: 1, toImage: UIImage(named: "\(index % 3 + 1)")!)
        //        touchToChangeColor(location: currentLocation!, radius: radius, animationDuration: 1, toColor: UIColor.randomColor())
        //        touchWaveAnimation(location: currentLocation!, radius: radius, animationDuration: 1)
        
    }
    
    
    /// 点击切换图片的效果
    ///
    /// - Parameters:
    ///   - location: 点击的位置
    ///   - radius: 水波纹半径
    ///   - animationDuration: 动画时长
    ///   - toImage: 切换到的图片
    func touchToChangeBackgoundImage(location: CGPoint, radius: CGFloat, animationDuration: Double, toImage: UIImage){
        
        //遮罩图层
        let mask = CALayer()
        mask.bounds = view.layer.bounds
        mask.position = view.center
        mask.contents = toImage.cgImage
        view.layer.addSublayer(mask)
        
        //以当前点为中心绘制半径为0的圆形
        let path = CGMutablePath()
        //        path.move(to: currentLocation!)
        path.addArc(center: location, radius: 1, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        //动画结束时的路径
        let toPath = CGMutablePath()
        
        //图形结束时的位置
        toPath.addArc(center:  location, radius: radius, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        
        //将圆形添加到图层
        let shape = CAShapeLayer()
        //设置遮罩图层的mask,mask属性和fillColor的alpa通道相关, 当给图层添加mask时图层不能有父类
        mask.mask = shape
        //如果fillColor的color的alpha值为0, 那么遮罩不起作用, 因为是透明的着不住
        shape.fillColor = UIColor.randomColor().cgColor
        shape.lineWidth = 0
        //圆形放大动画
        let scaleCircle = CABasicAnimation(keyPath: "path")
        scaleCircle.duration = animationDuration
        scaleCircle.fromValue = path
        scaleCircle.toValue = toPath
        shape.add(scaleCircle, forKey: "scale")
        
        //延时小于动画时间 (animationDuration * 0.9)防止动画结束时闪烁
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration * 0.9) {
            self.view.layer.contents = toImage.cgImage
            mask.removeFromSuperlayer()
            shape.removeFromSuperlayer()
        }
    }
    
    /// 点击改变背景颜色的方法
    ///
    /// - Parameters:
    ///   - location: 点击的位置
    ///   - radius: 水波纹半径
    ///   - toColor: 改变成的颜色
    func touchToChangeColor(location: CGPoint, radius: CGFloat, animationDuration: Double, toColor: UIColor) {
        view.layer.contents = nil
        //        view.layer.backgroundColor = toColor.cgColor;
        //以当前点为中心绘制半径为0的圆形
        let path = CGMutablePath()
        //        path.move(to: currentLocation!)
        path.addArc(center: location, radius: 1, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        //动画结束时的路径
        let toPath = CGMutablePath()
        //取屏幕宽高的平方根
        
        toPath.addArc(center:  location, radius: radius, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        
        //将圆形添加到图层
        let shape = CAShapeLayer()
        view.layer.addSublayer(shape)
        shape.lineWidth = 0
        shape.fillColor = toColor.cgColor
        //        shape.path = path
        //圆形放大动画
        let scaleCircle = CABasicAnimation(keyPath: "path")
        scaleCircle.duration = animationDuration
        scaleCircle.fromValue = path
        scaleCircle.toValue = toPath
        shape.add(scaleCircle, forKey: "scale")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration) {
            self.view.layer.backgroundColor = toColor.cgColor;
            shape.removeFromSuperlayer()
        }
    }
    
    /// 水波纹点击效果
    ///
    /// - Parameters:
    ///   - location: 点击的位置
    ///   - radius: 水波纹半径
    ///   - animationDuration: 动画时长
    func touchWaveAnimation(location: CGPoint, radius: CGFloat, animationDuration: Double)  {
        
        //以当前点为中心绘制半径为0的圆形
        let path = CGMutablePath()
        //        path.move(to: currentLocation!)
        path.addArc(center: location, radius: 10, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        //动画结束时的路径
        let toPath = CGMutablePath()
        //        toPath.move(to: currentLocation!)
        //取屏幕宽高的平方根
        //        let radius: CGFloat = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height)
        toPath.addArc(center:  location, radius: radius, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        
        //将圆形添加到图层
        let shape = CAShapeLayer()
        view.layer.addSublayer(shape)
        shape.lineWidth = 0
        shape.fillColor = UIColor(white: 1, alpha: 0.4).cgColor
        //        shape.path = path
        //圆形放大动画
        let scaleCircle = CABasicAnimation(keyPath: "path")
        scaleCircle.duration = animationDuration
        scaleCircle.fromValue = path
        scaleCircle.toValue = toPath
        shape.add(scaleCircle, forKey: "scale")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration) {
            shape.removeFromSuperlayer()
        }
        
    }
    
    
    /// 虚线滚动的动画
    func dashAnimation() {
        let shapeLayer = CAShapeLayer()
        let roundPath = CGPath(roundedRect: CGRect(x: 20, y: 400, width: 300, height: 100), cornerWidth: 20, cornerHeight: 20, transform: nil)
        
        shapeLayer.path = roundPath
        view.layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = 8
        shapeLayer.borderColor = UIColor.gray.cgColor
        shapeLayer.lineDashPattern = [3,3]//实线长度， 虚线长度， 依次循环，也可以是三个或者四个或者更多
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        //        shapeLayer.strokeStart =  0.5//渲染起点
        //        shapeLayer.strokeEnd = 0.7//渲染终点
        
        let timer = Timer(fire: Date(timeIntervalSinceNow: 0), interval: 0.15, repeats: true) { (timer) in
            //虚线开始的位置
            shapeLayer.lineDashPhase = shapeLayer.lineDashPhase - 3
        }
        let runlop = RunLoop.current
        runlop.add(timer, forMode: RunLoopMode.commonModes)
//        timer.fire()
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
