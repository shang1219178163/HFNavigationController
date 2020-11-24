//
//  FisrtViewController.swift
//  HalfModalPresentationController
//
//  Created by Martin Normark on 17/01/16.
//  Copyright © 2016 martinnormark. All rights reserved.
//

import UIKit
import SwiftExpand
import HFNavigationController
/// 第一步
class FisrtViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FisrtVC"
        view.backgroundColor = .systemGreen
 
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleItemLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleItemCanell))
    }
    
    @objc func handleItemLeft() {
        let controller = SecondViewController()
        navigationController?.pushViewController(controller, animated: true)
        navigationController?.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.9, height: 250)
//        print("\(#function)_\(navigationController!.preferredContentSize)")
//        if let navController = navigationController as? HFNavigationController{
//            navController.updatePresentedView(CGSize(width: UIScreen.main.bounds.width*0.9, height: 250))
//        }
    }
    
    @objc func handleItemCanell() {
        dismiss(animated: true, completion: nil)
    }
    
}
