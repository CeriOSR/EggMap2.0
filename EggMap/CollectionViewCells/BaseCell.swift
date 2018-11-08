//
//  BaseCell.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-18.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
