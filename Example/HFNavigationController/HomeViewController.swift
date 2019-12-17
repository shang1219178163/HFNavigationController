//
//  HomeViewController.swift
//  Tmp
//
//  Created by shang1219178163 on 12/14/2019.
//  Copyright (c) 2019 shang1219178163. All rights reserved.
//

import UIKit
import HFNavigationController
import SnapKit

class HomeViewController: UIViewController {
    
    let frameBottom = CGRect(x: 0,
                             y: UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.5,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height*0.5)
    
    let frameCenter = CGRect(x: 0,
                             y: UIScreen.main.bounds.height*0.25,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height*0.5)

    lazy var controller: HFNavigationController = {
        let controller = HFNavigationController(rootViewController: ThirdViewController())
        controller.setNavigationBarHidden(true, animated: false)
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = controller as UIViewControllerTransitioningDelegate
        return controller;
    }()
    
    lazy var navController: HFNavigationController = {
        let controller = HFNavigationController(rootViewController: FisrtViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = controller as UIViewControllerTransitioningDelegate
        return controller;
    }()
    
    // MARK: - 视图
    lazy var segmentCtrl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["bottom", "center"])
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(handleActionSender(_:)), for: .valueChanged)
        return view
    }()
    
    @objc func handleActionSender(_ sender: UISegmentedControl) {        

        switch sender.selectedSegmentIndex {
        case 1:
            controller.setupDefaultFrame(frameCenter)
            navController.setupDefaultFrame(frameCenter)
//            if let presentationController = controller.presentationController as? HFPresentationController{
//                presentationController.defaultFrame = frameCenter
//            }
//
//            if let presentationController = navController.presentationController as? HFPresentationNavController{
//                presentationController.defaultFrame = frameCenter
//            }
            
        default:
            controller.setupDefaultFrame(frameBottom)
            navController.setupDefaultFrame(frameBottom)
//            if let presentationController = controller.presentationController as? HFPresentationController{
//                presentationController.defaultFrame = frameBottom
//            }
//
//            if let presentationController = navController.presentationController as? HFPresentationNavController{
//                presentationController.defaultFrame = frameBottom
//            }
        }        
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
//        title = NSLocalizedString("主界面", comment: "")
        title = Bundle.localizedString(forKey: "半屏显示")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "控制器", style: .plain, target: self, action: #selector(handleItemLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "导航控制器", style: .plain, target: self, action: #selector(handleItemRight))
        
        view.addSubview(segmentCtrl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentCtrl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
    }
    
    @objc func handleItemLeft() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func handleItemRight() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(navController, animated: true, completion: nil)
        
    }

}

