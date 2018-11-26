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
    let hourGlassImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Cartoon Egg").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    let containerView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    let rateBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Rate", for: .normal)
        return btn
    }()

    
    override func setupViews() {
        super.setupViews()
        addSubview(orderLabel)
        addSubview(dateLabel)
        addSubview(statusLabel)
        addSubview(productLabel)
        addSubview(rateBtn)
        addSubview(containerView)
        addSubview(hourGlassImageView)

        containerView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 4, rightConstant: 4, widthConstant: 0, heightConstant: 0)
        orderLabel.anchor(self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: self.frame.width * 0.5, heightConstant: ScreenSize.height * 0.03)
        dateLabel.anchor(self.containerView.topAnchor, left: nil, bottom: nil, right: self.containerView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: self.frame.width * 0.5, heightConstant: ScreenSize.height * 0.03)
        productLabel.anchor(orderLabel.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.75, heightConstant: ScreenSize.height * 0.03)
        hourGlassImageView.anchor(dateLabel.bottomAnchor, left: productLabel.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: ScreenSize.height * 0.03)
        statusLabel.anchor(productLabel.bottomAnchor, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: ScreenSize.width * 0.75, heightConstant: 0)
        rateBtn.anchor(productLabel.bottomAnchor, left: statusLabel.rightAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        orderLabel.text = nil
        dateLabel.text = nil
        statusLabel.text = nil
        productLabel.text = nil

    }
}






