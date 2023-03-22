//
//  TeamDetailViewController.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Combine
import UIKit

final class TeamDetailViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: TeamDetailViewModel
    private var bindings = Set<AnyCancellable>()

    // MARK: - UI Properties
    private lazy var teamDetailView = TeamDetailView()

    // MARK: - Inits
    init(viewModel: TeamDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - loadView
    override func loadView() {
        view = teamDetailView
        title = viewModel.title
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        viewModel.fetchImage()
    }
}

// MARK: - Private methods
extension TeamDetailViewController {
    func setUpBindings() {
        func bindViewModelToView() {
            viewModel.$data
                .sink { [weak self] data in
                    guard let data else { return }
                    self?.teamDetailView.imageView.image = UIImage(data: data)
                }.store(in: &bindings)
        }

        bindViewModelToView()
    }
}
