//
//  UIAlertHelper.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-10-29.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class EggMapAlerts: UIAlertController {
    
    let textView = UITextView(frame: CGRect.zero)

    func acceptOrderAlert(sender: UIViewController) {
        let alert = UIAlertController(title: "Take Order", message: "Do you want to take this order?", preferredStyle: .alert)
        let take = UIAlertAction(title: "Ok", style: .default) { (action) in
            //send to database and move to Orders Taken
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: {
                //handle completion here if needed.
            })
        }
        alert.addAction(take)
        alert.addAction(cancel)
        sender.present(alert, animated: true) {
            //handle completion of alert presentation here if needed.
        }
        print("accept Item from database and remove item from collectionView")
    }
    
    func abortOrderAlert(sender: UIViewController) {
        let alert = UIAlertController(title: "Abort order?", message: "Unless absolutely necessary, we do not encourage aborting an order that is currently processed.", preferredStyle: .alert)
        textView.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let orderSummaryController = ClientSideOrderSummaryScreenController()
            let navOrderSummary = UINavigationController(rootViewController: orderSummaryController)
            sender.present(navOrderSummary, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.view.removeObserver(self, forKeyPath: "bounds")
            alert.dismiss(animated: true, completion: nil)
        }
        alert.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)        
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self.textView, queue: OperationQueue.main) { (notification) in
            action.isEnabled = self.textView.text != ""
        }
        self.textView.backgroundColor = UIColor.white
        alert.view.addSubview(self.textView)
        alert.addAction(cancel)
        alert.addAction(action)
        sender.present(alert, animated: true) {
            //completion handler here
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin:CGFloat = 8.0
                textView.frame = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 2)
                textView.bounds = CGRect.init(x: rect.origin.x + margin, y: rect.origin.y + margin, width: rect.width - 2*margin, height: rect.height / 2)
            }
        }
    }
    
}
