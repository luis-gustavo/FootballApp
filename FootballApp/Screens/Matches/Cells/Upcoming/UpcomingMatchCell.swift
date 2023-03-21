//
//  UpcomingMatchCell.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class UpcomingMatchCell: UICollectionViewCell {

    // MARK: - Properties
    private var viewModel: UpcomingMatchCellViewModel?

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

    private lazy var watchHighlightButton: UIButton = {
        let button = UIButton()
        button.roundCorners(radius: 20)
        button.setTitle(Localizable.highlights.localized, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.label, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            print(self)
            print("TAP HERE")
        }, for: .touchUpInside)
        return button
    }()

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - ViewCodable
extension UpcomingMatchCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews(
            dateHeader,
            homeTeam,
            awayTeam,
            versusLabel,
            watchHighlightButton
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
//            homeTeam.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            homeTeam.bottomAnchor.constraint(equalTo: watchHighlightButton.topAnchor, constant: -8),
            homeTeam.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 8),

            awayTeam.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            awayTeam.leadingAnchor.constraint(equalTo: versusLabel.trailingAnchor, constant: 8),
//            awayTeam.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            awayTeam.bottomAnchor.constraint(equalTo: watchHighlightButton.topAnchor, constant: -8),
            awayTeam.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 8),

            watchHighlightButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            watchHighlightButton.heightAnchor.constraint(equalToConstant: 40),
//            watchHighlightButton.widthAnchor.constraint(equalToConstant: 60),
            watchHighlightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.roundCorners(radius: 8)
    }
}

// MARK: - Internal methods
extension UpcomingMatchCell {
    func configure(with viewModel: UpcomingMatchCellViewModel) {
        self.viewModel = viewModel
        dateHeader.configure(with: viewModel.dateHeaderViewModel)
        homeTeam.configure(with: viewModel.homeViewModel)
        awayTeam.configure(with: viewModel.awayViewModel)
    }
}
