//
//  UIView+addSubviews.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
