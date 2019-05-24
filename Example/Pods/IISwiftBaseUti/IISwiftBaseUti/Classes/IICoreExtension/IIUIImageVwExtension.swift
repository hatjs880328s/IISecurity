//
//  *******************************************
//  
//  IIUIImageVwExtension.swift
//  IISwiftBaseUti
//
//  Created by Noah_Shan on 2019/5/21.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//


import UIKit

public extension UIImageView {

    /// 使imageview可以设置tintcolor
    @objc func setRenderImg() {
        self.image = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
}
