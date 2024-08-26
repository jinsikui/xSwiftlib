//
//  UIImageExtension.swift
//  wedevotebible
//
//  Created by 杜文泽 on 2021/12/14.
//  Copyright © 2021 WD Bible Team. All rights reserved.
//

import UIKit

extension UIImage {
    static func creatImageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    /// 更改图片颜色
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - blendMode: 模式
    /// - Returns: 返回更改后的图片颜色
    func tint(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        let drawRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        UIRectFill(drawRect)
        self.draw(in: drawRect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        guard let tintedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return tintedImage
    }
}
