//
//  HighlightFooterView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class HighlightFooterView: UIView {

    // MARK: - Properties
    private var viewModel: HighlightFooterViewModel?

    // MARK: - UI Properties
    private lazy var watchHighlightButton: UIButton = {
        let button = UIButton()
        button.roundCorners(radius: 20)
        button.setTitle(Localizable.highlights.localized, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.label, for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.viewModel?.showHighlight()
        }, for: .touchUpInside)
        button.setImage(.init(systemName: "play"), for: .normal)
        return button
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
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodable
extension HighlightFooterView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            watchHighlightButton,
            divisorView
        )
    }

    func setupConstraints() {
        let margin: CGFloat = 8

        NSLayoutConstraint.activate([
            divisorView.topAnchor.constraint(equalTo: topAnchor),
            divisorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            divisorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            divisorView.heightAnchor.constraint(equalToConstant: 2),

            watchHighlightButton.topAnchor.constraint(equalTo: divisorView.bottomAnchor, constant: 8),
            watchHighlightButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            watchHighlightButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            watchHighlightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Internal methods
extension HighlightFooterView {
    func configure(with viewModel: HighlightFooterViewModel) {
        self.viewModel = viewModel
    }
}
