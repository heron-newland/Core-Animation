//
//  HLLCAGradientLayerController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/18.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class HLLCAGradientLayerController: UIViewController {
    //进度条
    lazy var progressView:UIProgressView = {
        let progress = UIProgressView(frame: CGRect(x: 12, y: 500, width: UIScreen.main.bounds.width - 24, height: 30))
        progress.progressViewStyle = .default
      
        progress.setProgress(0, animated: false)
        progress.tintColor = UIColor.green
        progress.progressTintColor = UIColor.red
        return progress
    }()
    
    //滑动条
    lazy var slider:UISlider = {
        let slide = UISlider(frame: CGRect(x: 12, y: 550, width: UIScreen.main.bounds.width - 24, height: 30))
        slide.setValue(0, animated: false)
        slide.tintColor = UIColor.green
        slide.thumbTintColor = UIColor.blue
        slide.addTarget(self, action: #selector(slideAction), for: .valueChanged)
        slide.minimumValue = 0
        slide.maximumValue = 1
        return slide
    }()
    
    lazy var des = {() -> UILabel in
       let label = UILabel(frame: CGRect(x: 12, y: 450, width: UIScreen.main.bounds.width - 24, height: 40))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    let shapeLayer = CAShapeLayer()
    let lineLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.addSubview(progressView)
        view.addSubview(slider)
        view.addSubview(des)
        circleLayer()
        liner()
//        basicUsage()
    }

    
    //TODO: - 两个圆从相仿的方向绘制, 要用到后面的知识, 暂时
    func reverseCircle() {

        
    }
    func liner(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = view.bounds
        gradientLayer.position = view.center
        view.layer.addSublayer(gradientLayer)
        gradientLayer.colors  = [UIColor.randomColor().cgColor, UIColor.randomColor().cgColor, UIColor.randomColor().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 16, y: 100))
        path.addLine(to: CGPoint(x: view.bounds.width - 32, y: 100))
        lineLayer.path = path
        lineLayer.lineWidth = 12
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = UIColor.blue.cgColor
        lineLayer.strokeStart = 0
        lineLayer.strokeEnd = 0
        //设置遮罩
        gradientLayer.mask = lineLayer
    }
    
    /* 绘制圆形的动画
     *
     *  原理: 使用CAShapeLayer的 strokeStart, strokeEnd 两个属性做动画
     *  使用 CAGradientLayer 做颜色渐变
     *  使用 CAShapeLayer 作为 CAGradientLayer 的遮罩(mask属性)
     */
    func circleLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = view.bounds
        gradientLayer.position = view.center
        view.layer.addSublayer(gradientLayer)
        gradientLayer.colors  = [UIColor.randomColor().cgColor, UIColor.randomColor().cgColor, UIColor.randomColor().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        

        let path = CGMutablePath()
        path.addArc(center: view.center, radius: 100, startAngle: -CGFloat.pi, endAngle: CGFloat.pi, clockwise: false)
        shapeLayer.path = path
        shapeLayer.lineWidth = 12
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        //设置遮罩
        gradientLayer.mask = shapeLayer
        
    }
    //
    @objc func slideAction(){
      print(slider.value)
    progressView.setProgress(slider.value, animated: true)
        shapeLayer.strokeEnd = CGFloat(slider.value)
          lineLayer.strokeEnd = CGFloat(slider.value)
    
        des.text = "\(slider.value)"
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        basicUsage()
        
        
    }
  
    /// 基本用法
    func basicUsage() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = view.bounds
        gradientLayer.position = view.center
        view.layer.addSublayer(gradientLayer)
        //起始结束位置, 左上角为(0,0),右下角为(1,1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        //渐变颜色数组, cgColor类型
        gradientLayer.colors = [UIColor.randomColor().cgColor, UIColor.randomColor().cgColor, UIColor.randomColor().cgColor]
        //按比例分割起点到终点, 然后使用colors数组的颜色填充. 每一种颜色对应的比例,数字必须递增, 0 ~ 0.25 一种颜色, 0.25 ~ 0.5 第二种颜色, 0.5 ~ 1 第三种颜色
        gradientLayer.locations = [0, 0.25, 0.5, 1]
        
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
