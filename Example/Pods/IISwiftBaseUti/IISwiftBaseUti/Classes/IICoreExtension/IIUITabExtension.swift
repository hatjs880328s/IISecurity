//
//  *******************************************
//
//  IIuiTabExtension.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/3/4.
//  Copyright © 2018 Inpur. All rights reserved.
//
//  *******************************************
//

import Foundation
import SnapKit

/// OOP处理空列表显示信息
public extension UITableView {
    @objc public func iiExcEmailReload(isZeroCount: Bool, withNoTitle: String, imgName: String? = nil) {
        if isZeroCount {
            let emptyVw = IIExcTabEmptyVw(frame: CGRect.zero, nonTxt: withNoTitle, imgName: imgName)
            emptyVw.frame.size = self.frame.size
            emptyVw.frame.origin = CGPoint(x: 0, y: 0)
            self.backgroundView = emptyVw
        } else {
            self.backgroundView = nil
        }
        self.reloadData()
    }
}

public class IIUITabExtension {
    static let aWeight = UIScreen.main.bounds.size.width
}

/// 邮箱列表空列表vw
public class IIExcTabEmptyVw: UIView {

    public var createBtn = UIImageView()

    public var txtLb: UILabel = UILabel()

    public var showTitle: String = ""

    public var imgName: String?

    public init(frame: CGRect, nonTxt: String, imgName: String? = nil) {
        super.init(frame: frame)
        self.showTitle = nonTxt
        self.imgName = imgName
        createVw()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func createVw() {
        let bgVw = UIView()
        self.addSubview(bgVw)
        bgVw.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-20)
            make.width.equalTo(IIUITabExtension.aWeight)
            make.height.equalTo(220)
        }
        self.backgroundColor = UIColor.white
        bgVw.layer.cornerRadius = 5
        bgVw.layer.masksToBounds = true
        bgVw.addSubview(createBtn)
        bgVw.addSubview(txtLb)
        createBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(290)
            make.height.equalTo(200)
        }
        createBtn.image = UIImage(named: self.imgName ?? "webex_nocontent")
        txtLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(createBtn.snp.bottom)
            make.width.equalTo(250)
            make.height.equalTo(20)
        }
        txtLb.font = UIFont.systemFont(ofSize: 16)
        txtLb.textColor = UIColor(red: 221 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1)
        txtLb.text = showTitle
        txtLb.textAlignment = .center
    }
}
