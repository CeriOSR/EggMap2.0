//
//  ChatControllerToCell.swift
//  EggMap
//
//  Created by Rey Cerio on 14/12/2018.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ChatControllerToCell: BaseCell {
    
    let messageLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .right
        return lbl
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        return view
    }()
    override func setupViews() {
        addSubview(bubbleView)
        bubbleView.addSubview(messageLbl)
        bubbleView.addSubview(dateLbl)
        
        bubbleView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.8, heightConstant: 0)
        messageLbl.anchor(bubbleView.topAnchor, left: bubbleView.leftAnchor, bottom: nil, right: bubbleView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: bubbleView.frame.height * 0.75)
        dateLbl.anchor(messageLbl.bottomAnchor, left: bubbleView.leftAnchor, bottom: bubbleView.bottomAnchor, right: bubbleView.rightAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
}
