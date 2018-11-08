//
//  RateUserController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-10-28.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class RateUserController: UIViewController {
    
    var starRating : FiveStarRating = {
        let stars = FiveStarRating(frame: CGRect(x: (CGFloat(UIScreen.main.bounds.width) - CGFloat((5 * kStarSize) + (4 * kSpacing))) / 2
            , y: ScreenSize.height * 0.4, width: CGFloat((5 * kStarSize) + (4 * kSpacing)), height: CGFloat(kStarSize) ))
        return stars
    }()
    
    let instructionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "How was your experience with:"
        return lbl
    }()
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.text = "Gavin Belson"
        return lbl
    }()
    
    let commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = "Comments:"
        return lbl
    }()
    
    let commentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.layer.cornerRadius = 10
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.black.cgColor
        
        return tv
    }()
    
    let finishButton: UIButton = {
        let button = UIButton(type: .system)
        //        button.layer.borderWidth = 1
        //        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Finish", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        title = "Rate Gavin Benson"
        view.backgroundColor = .white
        view.addSubview(starRating)
        view.addSubview(nameLbl)
        view.addSubview(instructionLabel)
        view.addSubview(commentLbl)
        view.addSubview(commentTextView)
        view.addSubview(finishButton)
        
        instructionLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: starRating.leftAnchor, bottom: nil, right: starRating.rightAnchor, topConstant: ScreenSize.height * 0.21, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.02)
        
        nameLbl.anchor(instructionLabel.bottomAnchor, left: starRating.leftAnchor, bottom: starRating.topAnchor, right: starRating.rightAnchor, topConstant: ScreenSize.height * 0.005, leftConstant: 0, bottomConstant: ScreenSize.height * 0.005, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        commentLbl.anchor(starRating.bottomAnchor, left: starRating.leftAnchor, bottom: nil, right: starRating.rightAnchor, topConstant: ScreenSize.height * 0.05, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.02)
        
        commentTextView.anchor(commentLbl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: ScreenSize.height * 0.02, leftConstant: ScreenSize.width * 0.02, bottomConstant: ScreenSize.height * 0.2, rightConstant: ScreenSize.width * 0.02, widthConstant: 0, heightConstant: 0)
        
        finishButton.anchor(commentTextView.bottomAnchor, left: starRating.leftAnchor, bottom: nil, right: starRating.rightAnchor, topConstant: ScreenSize.height * 0.1, leftConstant: starRating.frame.width * 0.25, bottomConstant: 0, rightConstant: starRating.frame.width * 0.25, widthConstant: 0, heightConstant: ScreenSize.height * 0.05)
    }
    
}
