//
//  FiveStarRatingImageNonInteractiveView.swift
//  EggMap
//
//  Created by Mei on 2018-10-09.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class FiveStarRatingNonInteractiveImage: UIStackView {
    
    private var starImages = [UIImageView]()
    private var starCount = 5 {
        didSet{
            setupImages()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = CGFloat(kSpacing)
        setupImages()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImages() {
        //remove images on reload
        for image in starImages {
            removeArrangedSubview(image)
            image.removeFromSuperview()
        }
        
        for i in 0..<starCount {
            let image = UIImageView()
            image.image = #imageLiteral(resourceName: "emptyStar").withRenderingMode(.alwaysOriginal)
            
            image.accessibilityLabel = "\(i)"
            
            image.heightAnchor.constraint(equalToConstant: CGFloat(kStarSize)).isActive = true
            image.widthAnchor.constraint(equalToConstant: CGFloat(kStarSize)).isActive = true
            
            addArrangedSubview(image)
            starImages.append(image)
        }
    }    
}
