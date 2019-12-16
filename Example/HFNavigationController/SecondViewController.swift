//
//  NextViewController.swift
//  Tmp_Example
//
//  Created by Bin Shang on 2019/12/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
/// 第二步
class SecondViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SecondViewController"
        view.backgroundColor = .yellow
 
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleItemSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(handleItemBack(_:)))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleItemCanell(_:)))
        
//        modalPresentationStyle = .custom
//        transitioningDelegate = self;
    }
    
    @objc func handleItemBack(_ item: UIBarButtonItem) {
        print("handleItemSave")
        
        navigationController?.popViewController(animated: true)
        /// 必须放在跳转之后,不然会影响动画交互
        navigationController?.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 400)
    }
    
    @objc func handleItemCanell(_ item: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

