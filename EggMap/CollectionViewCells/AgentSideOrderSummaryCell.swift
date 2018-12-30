//
//  AgentSideOrderSummaryCell.swift
//  EggMap
//
//  Created by Mei on 2018-12-26.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class AgentSideOrderSummaryCell: BaseCell {
    
    let orderDetailsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = lbl.font.withSize(15)
        lbl.text = "Name: Richard Hendricks \nLocation: 12345 Northwest Rd. Richmond BC \nTime Accepted: 12:20 PM \nStatus: Confirmed, waiting for delivery"
        return lbl
    }()
    
    let abortButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Abort", for: .normal)
        return btn
    }()
    
    let chatBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Chat", for: .normal)
        return btn
    }()
    
    let hourglassImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "EggMapDude").withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(orderDetailsLbl)
        addSubview(abortButton)
        addSubview(chatBtn)
        addSubview(hourglassImageView)
        
        orderDetailsLbl.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 2, leftConstant: 2, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width * 0.75, heightConstant: self.frame.height * 0.7)
        abortButton.anchor(orderDetailsLbl.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 2, bottomConstant: 2, rightConstant: 0, widthConstant: self.frame.width * 0.5, heightConstant: 0)
        chatBtn.anchor(orderDetailsLbl.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 2, rightConstant: 2, widthConstant: self.frame.width * 0.5, heightConstant: 0)
        hourglassImageView.anchor(topAnchor, left: orderDetailsLbl.rightAnchor, bottom: chatBtn.topAnchor, right: rightAnchor, topConstant: 2, leftConstant: 0, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
    }
    
}
