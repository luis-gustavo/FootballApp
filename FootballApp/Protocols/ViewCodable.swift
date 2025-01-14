//
//  ViewCodable.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

protocol ViewCodable {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupViewConfiguration()
}

extension ViewCodable {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
