//
//  UIViewExtensions.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 12..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import UIKit

extension UIView {

    func addDropShadow(with color: UIColor = UIColor.black, opacity: Float = 0.75, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 1, scale: Bool = true, shouldRasterize: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = shouldRasterize
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

