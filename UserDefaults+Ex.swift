//
//  UserDefaults+Ex.swift
//  HFNavigationController
//
//  Created by Bin Shang on 2019/12/17.
//

import UIKit

@objc public extension UserDefaults{
    ///UserDefaults 存档对象(别忘了 synchronize)
    static func setArcObject(_ value: Any?, forkey defaultName: String) {
        guard let value = value else { return }
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        standard.setValue(data, forKey: defaultName)
    }
    ///UserDefaults 解档对象
    static func unarcObject(forkey defaultName: String) -> Any? {
        guard let value = standard.object(forKey: defaultName) as? Data else { return nil}
        return NSKeyedUnarchiver.unarchiveObject(with: value);
    }
    
}
