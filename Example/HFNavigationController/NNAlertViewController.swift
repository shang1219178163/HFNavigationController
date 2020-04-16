//
//  NNAlertViewController.swift
//  HFNavigationController_Example
//
//  Created by Bin Shang on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftExpand

class NNAlertViewController: UIViewController {
    
    let contentInset = UIEdgeInsets.zero
    
    
    lazy var textView: UITextView = {
        let textView = UITextView(frame: .zero)
        return textView
    }()

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(textView)
        
        view.getViewLayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textView.frame = CGRect(x: contentInset.left,
                                y: contentInset.top,
                                width: view.bounds.width - contentInset.left - contentInset.right,
                                height: view.bounds.height - contentInset.top - contentInset.bottom)
    }

}
