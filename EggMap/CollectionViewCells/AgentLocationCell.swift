//
//  LocationCell.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-08-13.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AgentLocationCell: BaseCell {
    
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(addressLabel)
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.frame.height * 0.3)
        addressLabel.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        addressLabel.text = nil
    }
}
