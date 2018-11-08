//
//  OrderSummaryCell.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-18.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class OrderSummaryCell: BaseCell {
    
    let orderLabel = UILabel()
    let dateLabel = UILabel()
    let statusLabel = UILabel()
    let productLabel = UILabel()

    
    override func setupViews() {
        super.setupViews()
        addSubview(orderLabel)
        addSubview(dateLabel)
        addSubview(statusLabel)
        addSubview(productLabel)

        orderLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width * 0.5, heightConstant: ScreenSize.height * 0.03)
        dateLabel.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width * 0.5, heightConstant: ScreenSize.height * 0.03)
        productLabel.anchor(orderLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        statusLabel.anchor(productLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        orderLabel.text = nil
        dateLabel.text = nil
        statusLabel.text = nil
        productLabel.text = nil

    }
}






