//
//  DateHeaderView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class DateHeaderView: UIView {

    // MARK: - UI Properties
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        return label
    }()

    private let divisorView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
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
extension DateHeaderView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            dateLabel,
            divisorView
        )
    }

    func setupConstraints() {

        let margin: CGFloat = 8

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: divisorView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),

            divisorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            divisorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            divisorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            divisorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Internal methods
extension DateHeaderView {
    func configure(with viewModel: DateHeaderViewModel) {
        dateLabel.text = viewModel.date
    }
}
