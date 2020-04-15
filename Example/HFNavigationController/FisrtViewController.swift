//
//  FisrtViewController.swift
//  HalfModalPresentationController
//
//  Created by Martin Normark on 17/01/16.
//  Copyright © 2016 martinnormark. All rights reserved.
//

import UIKit

/// 第一步
class FisrtViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FisrtVC"
        view.backgroundColor = .green
 
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleItemSave))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleItemCanell))
    }
    
    @objc func handleItemSave() {

        let controller = SecondViewController()
        navigationController?.pushViewController(controller, animated: true)
        /// 必须放在跳转之后,不然会影响动画交互
        navigationController?.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.9, height: 400)
    }
    
    @objc func handleItemCanell() {
        dismiss(animated: true, completion: nil)
    }
    
}
