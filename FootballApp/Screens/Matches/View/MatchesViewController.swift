//
//  MatchesViewController.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import CoreData
import Combine
import UIKit

final class MatchesViewController: UIViewController {

    // MARK: - typealias for Collection View Diffable Data Source
    private typealias DataSource = UICollectionViewDiffableDataSource<MatchesViewModel.Section, MatchesViewModel.Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<MatchesViewModel.Section, MatchesViewModel.Item>

    // MARK: - Properties
    private let viewModel: MatchesViewModel
    private var bindings = Set<AnyCancellable>()
    private var dataSource: DataSource!

    // MARK: - UI Properties
    private lazy var matchesView: MatchesView = {
        let view = MatchesView()
        view.searchBar.delegate = self
        view.searchBar.searchTextField.delegate = self
        return view
    }()

    // MARK: - Inits
    init(viewModel: MatchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - loadView
    override func loadView() {
        view = matchesView
        title = Localizable.matches.localized
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        viewModel.fetchData()
        configureDataSource()
    }
}

// MARK: - Private methods
private extension MatchesViewController {
    private func setUpBindings() {
        func bindViewModelToView() {
            viewModel.dataChanged
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)

            let stateValueHandler: (MatchesViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.matchesView.startLoading()
                case .finishedLoading:
                    self?.matchesView.stopLoading()
                case let .error(error):
                    self?.matchesView.stopLoading()
                    self?.viewModel.showError(error)
                }
            }

            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        bindViewModelToView()
    }

    func updateSections() {
        var snapshot = Snapshot()
        let sections = MatchesViewModel.Section.allCases

        snapshot.appendSections(sections)

        sections.forEach { section in
            switch section {
            case .previous:
                snapshot.appendItems(viewModel.filteredPreviousMatches.map { .previous($0) }, toSection: section)
            case .upcoming:
                snapshot.appendItems(viewModel.filteredUpcomingMatches.map { .upcoming($0) }, toSection: section)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func configureDataSource() {
        dataSource = DataSource(
            collectionView: matchesView.collectionView,
            cellProvider: { (collectionView, indexPath, match) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MatchCell.identifier,
                    for: indexPath
                ) as? MatchCell
                let viewModel = self.viewModel.cellViewModel(for: match)
                cell?.configure(with: viewModel)
                return cell
            }
        )

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let section = self.dataSource.snapshot()
                .sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.identifier,
                for: indexPath
            ) as? SectionHeaderReusableView
            view?.titleLabel.text = section.title
            return view
        }
    }
}

// MARK: - UISearchBarDelegate
extension MatchesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchText(searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
        viewModel.updateSearchText("")
    }
}

// MARK: - UITextFieldDelegate
extension MatchesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
