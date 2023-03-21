//
//  TeamView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import UIKit

final class TeamView: UIView {

    // MARK: - Properties
    private var bindings = Set<AnyCancellable>()
    private var viewModel: TeamViewModel?

    // MARK: - UI Properties
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.roundCorners(radius: 30)
        view.backgroundColor = .tertiarySystemBackground
        view.layer.borderWidth = 2
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
extension TeamView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            imageView,
            activityIndicatorView,
            titleLabel
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: imageView.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

// MARK: - Internal methods
extension TeamView {
    func configure(with viewModel: TeamViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        imageView.layer.borderColor = (viewModel.status == .winner ? UIColor.systemGreen : viewModel.status == .loser ? .systemRed : .clear).cgColor
        setUpBindings(viewModel: viewModel)
        viewModel.fetchImage()
    }
}

// MARK: - Private methods
private extension TeamView {
    func setUpBindings(viewModel: TeamViewModel) {
        func bindViewModelToView() {
            viewModel.$data
                .receive(on: RunLoop.main)
                .sink { [weak self] data in
                    guard let data = data else { return }
                    self?.imageView.image = UIImage(data: data)
                }.store(in: &bindings)

            let stateValueHandler: (TeamViewModel.State) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicatorView.isHidden = false
                    self?.activityIndicatorView.startAnimating()
                case .finishedLoading:
                    self?.activityIndicatorView.isHidden = true
                }
            }

            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }

        bindViewModelToView()
    }
}
