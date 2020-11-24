//
//  NNAlertViewController.swift
//  HFNavigationController_Example
//
//  Created by Bin Shang on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import HFNavigationController
import SwiftExpand
import SnapKit

class NNAlertViewController: HFViewController {
    
    private let contentInset = UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        return view
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView(frame: .zero)
        return view
    }()
    
    lazy var lineView: UIView = {
        var view = UIView(frame: .zero);
        view.backgroundColor = UIColor.hexValue(0xE5E5E5, a: 1)
        
        return view;
    }()
    
    lazy var btn: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("知道了", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemTeal

        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(lineView)
        view.addSubview(btn)

        textView.textAlignment = .right
        textView.font = UIFont.systemFont(ofSize: 16)

        titleLabel.text = "HFViewController 控制器弹窗"
        textView.text = """
            A man can be destroyed，but not defeated.
            一个人可以被毁灭，但不能被打败。
            ——《老人与海》
            """
        
        titleLabel.backgroundColor = .systemYellow
        textView.backgroundColor = .systemGreen
        lineView.backgroundColor = .systemRed
//        view.getViewLayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let labHeight: CGFloat = 25
        let btnHeight: CGFloat = 50

        let top = titleLabel.isHidden == false ? contentInset.top + labHeight + 8 : contentInset.top

        if titleLabel.isHidden == false {
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(contentInset.top);
                make.left.equalToSuperview().offset(contentInset.left);
                make.right.equalToSuperview().offset(-contentInset.right);
                make.height.equalTo(labHeight);
            }
        }
                
        btn.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(contentInset.left);
            make.right.equalToSuperview().offset(-contentInset.right);
            make.bottom.equalToSuperview()
            make.height.equalTo(btnHeight);
        }
        
        lineView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(btn.snp.top).offset(0);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.height.equalTo(1);
        }
        
        textView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(top);
            make.left.equalToSuperview().offset(contentInset.left);
            make.right.equalToSuperview().offset(-contentInset.right);
            make.bottom.equalTo(lineView.snp.top).offset(0);
        }
    }

}
