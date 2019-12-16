//
//  HomeViewController.swift
//  HFNavigationController
//
//  Created by shang1219178163 on 12/16/2019.
//  Copyright (c) 2019 shang1219178163. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        title = "主界面"
//        title = NSLocalizedString("主界面", comment: "")
        title = Bundle.localizedString(forKey: "主界面")
        
//        let format = NSLocalizedString("%i views", comment: "{总浏览量} views")
//        print(String(format: format, 20))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

