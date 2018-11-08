//
//  MapMarkerInfoWindow.swift
//  EggMap
//
//  Created by Mei on 2018-10-20.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class MapMarkerInfoWindow: UIView {
    
    let addressLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "99999999 address here street"
        return lbl
    }()
    
    let infoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysTemplate), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(addressLabel)
        addSubview(infoBtn)
        
        addressLabel.anchor(topAnchor, left: leftAnchor, bottom: centerYAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.frame.height * 0.5)
        infoBtn.anchor(addressLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
