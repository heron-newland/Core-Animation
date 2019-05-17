//
//  HLLCATransformLayerController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/19.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class HLLCATransformLayerController: UIViewController {

    lazy var slide: UISlider = {
        let sli = UISlider(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: 30))
        sli.tintColor = UIColor.green
        sli.thumbTintColor = UIColor.blue
        sli.minimumValue = -0.011
        sli.maximumValue = 0.011
        sli.setValue(0, animated: false)
        sli.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        sli.isHidden = true
        return sli
    }()
    
    let layer2 = CALayer()
    
    let cubic = CATransformLayer()
    
    let cubicWidth:CGFloat = 100
    
    let contianer = CATransformLayer()
    
    var startPoint = CGPoint.zero
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        view.addSubview(slide)
        
        basicUsage()
        generateCubic()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       startPoint = (touches.first?.location(in: view))!
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentP = (touches.first?.location(in: view))!
        let deltaX = currentP.x - startPoint.x
        let deltaY = currentP.y - startPoint.y
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, offsetX + CGFloat.pi * 0.5 * deltaY / cubicWidth, 1, 0, 0)
        transform = CATransform3DRotate(transform, offsetY + CGFloat.pi * 0.5 * deltaX / cubicWidth, 0, 1, 0)
        cubic.transform = transform
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let endP = (touches.first?.location(in: view))!
        let deltaX = endP.x - startPoint.x
        let deltaY = endP.y - startPoint.y
        offsetY = CGFloat.pi * 0.5 * deltaX / cubicWidth
        offsetX = -CGFloat.pi * 0.5 * deltaY / cubicWidth
    }
    func generateCubic() {
        
        var transform = CATransform3DIdentity
       
        cubic.bounds = view.bounds
        cubic.position = CGPoint(x: view.center.x, y: view.center.y + 120)
        cubic.transform = transform
        view.layer.addSublayer(cubic)
        
        
        
        let font = surface(With: UIColor.red)
        font.transform = CATransform3DMakeTranslation(0, 0, cubicWidth * 0.5)
        cubic.addSublayer(font)
        
        let back = surface(With: UIColor.purple)
        back.transform = CATransform3DMakeTranslation(0, 0, -cubicWidth * 0.5)
        cubic.addSublayer(back)
        
        let right = surface(With: UIColor.orange)
        right.transform = CATransform3DMakeTranslation(cubicWidth * 0.5, 0, 0)
        right.transform = CATransform3DRotate(transform,CGFloat.pi * 0.5, 0, 1, 0)
        cubic.addSublayer(right)
        
        let left = surface(With: UIColor.yellow)
        transform = CATransform3DRotate(transform,CGFloat.pi * 0.5, 0, 1, 0)
        transform = CATransform3DMakeTranslation(-cubicWidth * 0.5, 0, 0)
        left.transform = transform
        cubic.addSublayer(left)
        
        let up = surface(With: UIColor.green)
        up.transform = CATransform3DMakeTranslation(0, -cubicWidth * 0.5, 0)
        up.transform = CATransform3DMakeRotation(CGFloat.pi * 0.5, 1, 0, 0)
        cubic.addSublayer(up)
        
        let down = surface(With: UIColor.blue)
        down.transform = CATransform3DMakeTranslation(0, cubicWidth * 0.5, 0)
        down.transform = CATransform3DMakeRotation(CGFloat.pi * 0.5, 1, 0, 0)
        cubic.addSublayer(down)
    }
    
    
    func surface(With color: UIColor) -> CALayer {
        let font = CALayer()
        font.bounds = CGRect(x: 0, y: 0, width: cubicWidth, height: cubicWidth)
        font.position = CGPoint(x: view.center.x, y: view.center.y + 120)
        font.backgroundColor = color.cgColor
        return font
    }
    /*
     *
     ** CATransform3D中m34代表景深效果
     */
    func basicUsage() {

        slide.isHidden = false
        
        contianer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        contianer.position = CGPoint(x: view.center.x, y: view.center.y - 100)
        var transform = CATransform3DIdentity
        //contianer图层的transform会应用到所有子视图中, 能统一容器中所有子视图的transform效果,统一容器中透视效果一直, 有利于保持画面逼真的效果
        transform.m34 = -1.0 / 500
        contianer.transform = CATransform3DRotate(transform, CGFloat.pi * 0.25, 0, 1, 0)
        view.layer.addSublayer(contianer)
        
        let layer1 = CALayer()
        layer1.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        layer1.position = CGPoint(x: 100, y: 100)
        layer1.borderWidth = 10
        layer1.borderColor = UIColor.gray.cgColor
        layer1.backgroundColor = UIColor.red.cgColor
       
        //使用CATransform3DMakeRotation 即使设置了m34产生不了景深效果, 只有使用CATransform3DRotate并设置m34才能产生景深效果
//        layer1.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat.pi * 0.35, 1, 0, 0)
//        layer1.transform.m34 = -1.0/500.0
//        view.layer.addSublayer(layer1)
        
        
        layer2.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer2.position = CGPoint(x: 100, y: 100)
        layer2.cornerRadius = 20
        layer2.borderWidth = 10
        layer2.borderColor = UIColor.gray.cgColor
        layer2.backgroundColor = UIColor.blue.cgColor
       
        //transform就是景深
//        layer2.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat.pi * 0.25, 0, 1, 0)
//        layer2.transform = CATransform3DMakeTranslation(10, 0, 0)
        contianer.addSublayer(layer1)
        contianer.addSublayer(layer2)
        
    }
    
    
    @objc func sliderAction(){
        print(slide.value)
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(slide.value)
        contianer.transform = CATransform3DRotate(transform, CGFloat.pi * 0.25, 0, 1, 0)
       
        
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
