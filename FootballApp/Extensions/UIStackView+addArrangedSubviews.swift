//
//  UIStackView+addArrangedSubviews.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
