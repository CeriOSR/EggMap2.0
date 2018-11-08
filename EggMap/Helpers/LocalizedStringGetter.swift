//
//  LocalizedStringGetter.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-09-10.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class LocalizedStringGetter {
    
    func fetchLocalizedAttributedString(localizedString: String, comment: String, size: Int? = 17) -> NSMutableAttributedString {
        let greetingsMessage = NSLocalizedString(localizedString, comment: comment)
        let attributedString = NSMutableAttributedString(string: greetingsMessage, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
    }
}
