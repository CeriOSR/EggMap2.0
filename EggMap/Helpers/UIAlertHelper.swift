//
//  UIAlertHelper.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-10-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func alertActionTwoButtons(title: String, message: String, actionOne: String, actionTwo: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter reason for aborting order."
        }
        let action = UIAlertAction(title: actionOne, style: .default) { (action) in
            self.dismiss(animated: true, completion: {
                //completion handler here
            })
        }
        let cancel = UIAlertAction(title: actionTwo, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(action)
//        present(alert, animated: true) {
//            //completion handler here
//        }
    }
}
