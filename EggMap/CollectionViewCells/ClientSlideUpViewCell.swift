//
//  ClientSlideUpViewCell.swift
//  EggMap
//
//  Created by Mei on 2018-10-13.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ClientSlideUpViewCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "ABCDEFG SuperMarket"
        return label
    }()
    let addressLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "99999 Alderbridge Rd. Richmond BC"
        return label
    }()
    let typeImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(typeImage)
        
        typeImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 0, widthConstant: 50, heightConstant: 0)
        
        nameLabel.anchor(topAnchor, left: typeImage.rightAnchor, bottom: centerYAnchor, right: rightAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 2, widthConstant: 0, heightConstant: 0)
        
        addressLabel.anchor(centerYAnchor, left: typeImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 2, widthConstant: 0, heightConstant: 0)
    }
    
}
