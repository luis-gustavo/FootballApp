//
//  MatchCell.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class MatchCell: UICollectionViewCell {

    // MARK: - Properties
    private var viewModel: MatchCellViewModel?

    // MARK: - UI Properties
    private let dateHeader = DateHeaderView()

    private let homeTeam = TeamView()

    private let awayTeam = TeamView()

    private let versusLabel: UILabel = {
        let label = UILabel()
        label.text = "x"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = .systemRed
        return label
    }()

    private let highlightFooterView = HighlightFooterView()
    private var highlightFooterViewHeightConstraint: NSLayoutConstraint?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        homeTeam.imageView.image = nil
        homeTeam.titleLabel.text = nil
        awayTeam.imageView.image = nil
        awayTeam.titleLabel.text = nil
        dateHeader.dateLabel.text = nil
        highlightFooterViewHeightConstraint?.constant = 0
    }
}

// MARK: - ViewCodable
extension MatchCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews(
            dateHeader,
            homeTeam,
            awayTeam,
            versusLabel,
            highlightFooterView
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateHeader.heightAnchor.constraint(equalToConstant: 40),

            versusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            versusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            homeTeam.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            homeTeam.trailingAnchor.constraint(equalTo: versusLabel.leadingAnchor, constant: -8),
            homeTeam.bottomAnchor.constraint(equalTo: highlightFooterView.topAnchor, constant: -8),
            homeTeam.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 8),

            awayTeam.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            awayTeam.leadingAnchor.constraint(equalTo: versusLabel.trailingAnchor, constant: 8),
            awayTeam.bottomAnchor.constraint(equalTo: highlightFooterView.topAnchor, constant: -8),
            awayTeam.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 8),

            highlightFooterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            highlightFooterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            highlightFooterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            highlightFooterView.heightAnchor.constraint(equalToConstant: 50)
        ])

        highlightFooterViewHeightConstraint = .init(
            item: highlightFooterView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 50
        )
        highlightFooterViewHeightConstraint?.isActive = true
    }

    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.roundCorners(radius: 8)
    }
}

// MARK: - Internal methods
extension MatchCell {
    func configure(with viewModel: MatchCellViewModel) {
        self.viewModel = viewModel
        dateHeader.configure(with: viewModel.dateHeaderViewModel)
        highlightFooterView.configure(with: viewModel.highlightFooterViewModel)
        homeTeam.configure(with: viewModel.homeViewModel)
        awayTeam.configure(with: viewModel.awayViewModel)
        highlightFooterViewHeightConstraint?.constant = viewModel.showHighlight ? 50 : 0
    }
}
