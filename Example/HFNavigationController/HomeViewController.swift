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
        
    lazy var pvc: ThirdViewController = {
        let controller = ThirdViewController()
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = controller as UIViewControllerTransitioningDelegate
        return controller;
    }()
    
    lazy var pvcNavController: HFNavigationController = {
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
        let frameBottom = CGRect(x: 0,
                                 y: UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.5,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height*0.5)
        
        let frameCenter = CGRect(x: 0,
                                 y: UIScreen.main.bounds.height*0.25,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height*0.5)
        
        switch sender.selectedSegmentIndex {
        case 1:
            
            if let presentationController = pvc.presentationController as? HFPresentationController{
                presentationController.defaultFrame = frameCenter
            }
            
            if let presentationController = pvcNavController.presentationController as? HFPresentationNavController{
                presentationController.defaultFrame = frameCenter
            }
            
            
        default:
            if let presentationController = pvc.presentationController as? HFPresentationController{
                presentationController.defaultFrame = frameBottom
            }
            
            if let presentationController = pvcNavController.presentationController as? HFPresentationNavController{
                presentationController.defaultFrame = frameBottom
            }
        }
    }

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
        rootViewController.present(pvc, animated: true, completion: nil)
        
    }
    
    @objc func handleItemRight() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(pvcNavController, animated: true, completion: nil)
        
    }

}

