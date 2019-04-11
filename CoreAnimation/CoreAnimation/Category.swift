//
//  Category.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/18.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

extension UIColor {

    static func randomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green:  CGFloat(arc4random_uniform(255)) / 255.0, blue:  CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1)
    }
}
