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
import SwiftExpand

class HomeViewController: UIViewController {
    
    let frameBottom = CGRect(x: 0,
                             y: UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.5,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height*0.5)
    
    let frameCenter = CGRect(x: 0,
                             y: UIScreen.main.bounds.height*0.25,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height*0.5)
    
    let frameTop = CGRect(x: 0,
                          y: 44,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height*0.5)

//    lazy var controller: HFNavigationController = {
//        let controller = HFNavigationController(rootViewController: ThirdViewController())
//        controller.setNavigationBarHidden(true, animated: false)
//
//        controller.view.layer.cornerRadius = 15
//        controller.view.layer.masksToBounds = true
//        return controller;
//    }()
    
    lazy var controller: NNAlertViewController = {
        let controller = NNAlertViewController()        
        controller.view.layer.cornerRadius = 15
        controller.view.layer.masksToBounds = true
        return controller;
    }()
    
    lazy var navController: HFNavigationController = {
        let controller = HFNavigationController(rootViewController: FisrtViewController())
        controller.modalTransitionStyle = .crossDissolve
        
        controller.view.layer.cornerRadius = 15
        controller.view.layer.masksToBounds = true
        return controller;
    }()
    
    //MARK: - layz
    lazy var tableView: UITableView = {
        let table = UITableView(frame:self.view.bounds, style:.plain);
        table.rowHeight = 60
        table.dataSource = self;
        table.delegate = self;

        return table;
    }();
    
    lazy var segmentCtrl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["bottom", "center", "top"])
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(handleActionSender(_:)), for: .valueChanged)
        return view
    }()
    
    @objc func handleActionSender(_ sender: UISegmentedControl) {        

        switch sender.selectedSegmentIndex {
        case 1:
            controller.setupDefaultFrame(frameCenter)
            navController.setupDefaultFrame(frameCenter)
            
        case 2:
            controller.setupDefaultFrame(frameTop)
            navController.setupDefaultFrame(frameTop)
            
        default:
            controller.setupDefaultFrame(frameBottom)
            navController.setupDefaultFrame(frameBottom)

        }
    }
    
    var indexP: IndexPath = IndexPath(row: 0, section: 0)
    
    lazy var list: [String] = {
        let list = ["默认", "fade进fade出", "right进left出", "left进right出", "top进bottom出"]
        return list
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
//        title = NSLocalizedString("主界面", comment: "")
        title = Bundle.localizedString(forKey: "半屏显示")
        self.definesPresentationContext = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "控制器", style: .plain, target: self, action: #selector(handleItemLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "导航控制器", style: .plain, target: self, action: #selector(handleItemRight))
        
        view.addSubview(segmentCtrl)
        view.addSubview(tableView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentCtrl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(35)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentCtrl.snp.bottom).offset(2);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(0);
        }
    }
    
    @objc func handleItemLeft() {
//        controller.setupDefaultHeight(UIScreen.main.bounds.height*0.8)
        
//        let rect = CGRect(x: 0,
//                          y: 20,
//                        width: UIScreen.main.bounds.width*0.75,
//                        height: UIScreen.main.bounds.height*0.5)
//        controller.setupDefaultFrame(rect)
//        controller.setAnimateType(.fade, isShow: true)
//        controller.setAnimateType(.fade, isShow: false)

        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(controller, animated: true, completion: nil)
        
    }
    
    @objc func handleItemRight() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(navController, animated: true, completion: nil)
        
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    //    MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.dequeueReusableCell(tableView)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = indexP == indexPath ? UIColor.theme : UIColor.textColor6;
        cell.accessoryType = indexP == indexPath ? .checkmark : .none;
        
        guard let value = list[indexPath.row] as String? else { return cell }
        cell.textLabel?.text = value
        
//        cell.getViewLayer()
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexP != indexPath  {
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            newCell?.textLabel?.textColor = UIColor.theme

            let oldCell = tableView.cellForRow(at: indexP)
            oldCell?.accessoryType = .none
            oldCell?.textLabel?.textColor = UIColor.textColor6;
            indexP = indexPath
        }



        var showAnimateType: HFTransitionAnimator.AnimateType = .bottom
        var hideAnimateType: HFTransitionAnimator.AnimateType = .top

        switch indexPath.row {
        case 1:
            showAnimateType = .fade
            hideAnimateType = .fade
        case 2:
            showAnimateType = .right
            hideAnimateType = .left
        case 3:
            showAnimateType = .left
            hideAnimateType = .right
        case 4:
            showAnimateType = .top
            hideAnimateType = .bottom
        default:
            break
        }
        navController.setAnimateType(showAnimateType, isShow: true)
        navController.setAnimateType(hideAnimateType, isShow: false)
        
//        navController.popToRootViewController(animated: false)
//        navController.dismiss(animated: false, completion: nil)
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootViewController.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section == 0 ? "location" : "animation"
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView();
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel(frame: .zero);
//        //        label.backgroundColor = .green;
//        //        label.text = "header\(section)";
//        return label;
//    }
    
}

