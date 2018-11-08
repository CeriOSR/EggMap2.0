//
//  OrientationLockHelper.swift
//  EggMap
//
//  Created by Mei on 2018-10-02.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        
    }
    
}

//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    AppUtility.lockOrientation(.portrait)
//    // Or to rotate and lock
//    // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
//
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//
//    // Don't forget to reset when view is being removed
//    AppUtility.lockOrientation(.all)
//}
