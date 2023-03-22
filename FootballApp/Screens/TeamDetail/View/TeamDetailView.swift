//
//  TeamDetailView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import UIKit

final class TeamDetailView: UIView {

    // MARK: - UI Properties
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodable
extension TeamDetailView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            imageView
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
