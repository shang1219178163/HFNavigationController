//
//  ThirdViewController.swift
//  HFNavigationController_Example
//
//  Created by Bin Shang on 2019/12/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import HFNavigationController

/// 第三步
class ThirdViewController: HFViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FisrtViewController"
        view.backgroundColor = .cyan
 
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleItemSave))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleItemCanell))
    }
    
    @objc func handleItemSave() {

        let controller = SecondViewController()
        navigationController?.pushViewController(controller, animated: true)
        /// 必须放在跳转之后,不然会影响动画交互
        navigationController?.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.5, height: 250)
    }
    
    @objc func handleItemCanell() {
        dismiss(animated: true, completion: nil)
    }
    
}
