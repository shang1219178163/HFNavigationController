//
//  PopoverDemoController.swift
//  HFNavigationController_Example
//
//  Created by Bin Shang on 2021/6/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class PopoverDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.systemGreen
        
        title = "popover 呈现"
        
        navigationItem.rightBarButtonItems = ["done"].map({
            let sender = UIButton(type: .custom)
            sender.setTitle($0, for: .normal)
            sender.setTitleColor(.black, for: .normal)
            sender.addTarget(self, action: #selector(handlecAction(_:)), for: .touchUpInside)
            return UIBarButtonItem(customView: sender)
        })
    }

    @objc func handlecAction(_ sender: UIButton) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.blue
        
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 300, height: 600)

        let ppc = vc.popoverPresentationController
//        ppc?.permittedArrowDirections = .any
        ppc?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)

        ppc?.sourceView = sender
        ppc?.sourceRect = sender.frame

        ppc?.delegate = self
        present(vc, animated: true, completion: nil)
    }


}


extension PopoverDemoController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
