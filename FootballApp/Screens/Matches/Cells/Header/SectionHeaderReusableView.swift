//
//  SectionHeaderReusableView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {

    // MARK: - Private methods
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize,
            weight: .bold
        )
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodable
extension SectionHeaderReusableView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            titleLabel
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
          titleLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
          titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
          titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
          titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
