//
//  ClientProfileCell.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-25.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ClientProfileCell: BaseCell {
    
    
    let client = ClientProfileView()
    override func setupViews() {
        addSubview(client)
        client.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
