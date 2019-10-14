//
//  *******************************************
//
//  IISearchBar.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/2/28.
//  Copyright © 2018 Inpur. All rights reserved.
//
//  *******************************************
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

public protocol IISearchBarDelegate: NSObjectProtocol {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool

    func textFieldDidEndEditing(_ textField: UITextField)

    func textFieldShouldClear(_ textField: UITextField) -> Bool

    func textFieldShouldReturn(_ textField: UITextField) -> Bool

    func each5MillSecsTxtInfo(_ txtInfo: String)

}

/// 自定义search bar
public class IISearchBar: UIView {

    public var field: UITextField = UITextField()

    public weak var del: IISearchBarDelegate?

    let leftImg = UIButton()

    /// 是否显示放大镜
    public var showSearchIcon = false

    public init(frame: CGRect, showSearchIcon: Bool = false) {
        super.init(frame: frame)
        self.showSearchIcon = showSearchIcon
        createVw()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createVw() {
        self.addSubview(field)
        self.field.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        self.layer.masksToBounds = true
        self.field.delegate = self
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: 13)
        field.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        field.backgroundColor = UIColor(red: 246 / 255, green: 246 / 255, blue: 246 / 255, alpha: 1)
        field.clearButtonMode = .whileEditing
        //left search img
        if self.showSearchIcon {
            field.leftView = leftImg
            leftImg.frame = CGRect(x: 3, y: 3, width: 22, height: 22)
            leftImg.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
            leftImg.setImage(UIImage(named: "work_bench_searchvc_search"), for: UIControl.State.normal)
            field.leftViewMode = .always
        }
        //圆角
        self.layer.cornerRadius = 5
        _ = self.field.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { [weak self] events in
                self?.del?.each5MillSecsTxtInfo(events.element ?? "")
        }
    }
}

extension IISearchBar: UITextFieldDelegate {

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.del?.textFieldShouldBeginEditing(textField) ?? true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.del?.textFieldDidEndEditing(textField)
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.del?.textFieldShouldClear(textField) ?? true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.del?.textFieldShouldReturn(textField) ?? true
    }

}
