//
//  UIView+roundCorners.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
