//
//  *******************************************
//
//  IIImageExtension.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/3/7.
//  Copyright © 2018 Inpur. All rights reserved.
//
//  *******************************************
//

import Foundation

/*
 图片资源处理

 当需要根据不同主题获取不同图片时，
 蓝色主题： BlueTheme.bundle
 灰色主题： BlueTheme.bundle
 白色主题（默认） ： mainbundle
 */
public class IIImage: NSObject {

    @objc public var image: UIImage?

    //APPUIConfigManager.getInstance().getCurrentColorThemeId()
    //ColorThemeWhite = 0,
    //ColorThemeBlue,
    //ColorThemeGray
    // 切换主题时 & 启动app时需要设置此属性
    @objc public static var themeType = 0

    @objc public init?(named name: String, fileType type: String = "png", inDictionary dic: String?) {
        switch IIImage.themeType {
        case 1:
            let bundlePath = Bundle.main.path(forResource: "BlueTheme", ofType: "bundle") ?? ""
            let path = Bundle(path: bundlePath)?.path(forResource: name, ofType: type, inDirectory: dic) ?? ""
            self.image = UIImage(contentsOfFile: path)
        case 2:
            let bundlePath = Bundle.main.path(forResource: "GrayTheme", ofType: "bundle") ?? ""
            let path = Bundle(path: bundlePath)?.path(forResource: name, ofType: type, inDirectory: dic) ?? ""
            self.image = UIImage(contentsOfFile: path)
        default:
            self.image = UIImage(named: name)
        }
        // 如果构造失败，则是用白色主题构造
        if self.image == nil {
            self.image = UIImage(named: name)
        }
    }
}
