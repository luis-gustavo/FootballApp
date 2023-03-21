//
//  MatchesViewController.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

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
        return view
    }()

    // MARK: - Inits
    init(viewModel: MatchesViewModel = MatchesViewModel()) {
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
        viewModel.fetchData()
        configureDataSource()
        setUpBindings()
    }
}

// MARK: - Private methods
private extension MatchesViewController {
    private func setUpBindings() {
        func bindViewModelToView() {
            viewModel.$previousMatches
                .receive(on: RunLoop.main)
                .sink { [weak self] _ in
                    self?.updateSections()
                }
                .store(in: &bindings)

            viewModel.$upcomingMatches
                .receive(on: RunLoop.main)
                .sink { [weak self] _ in
                    self?.updateSections()
                }
                .store(in: &bindings)

            let stateValueHandler: (MatchesViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loadingTeams, .loadingMatches:
                    self?.matchesView.startLoading()
                case .finishedLoading:
                    self?.matchesView.stopLoading()
                case let .error(error):
                    print(error.localizedDescription)
                    break
//                    self?.contentView.finishLoading()
//                    self?.showError(error)
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
                snapshot.appendItems(viewModel.previousMatches.map { .previous($0) }, toSection: section)
            case .upcoming:
                snapshot.appendItems(viewModel.upcomingMatches.map { .upcoming($0) }, toSection: section)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func configureDataSource() {
        dataSource = DataSource(
            collectionView: matchesView.collectionView,
            cellProvider: { (collectionView, indexPath, match) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: UpcomingMatchCell.identifier,
                    for: indexPath
                ) as? UpcomingMatchCell
                let imagesUrls = self.viewModel.imagesUrls(for: match)
                let viewModel = UpcomingMatchCellViewModel(
                    dateHeaderViewModel: .init(
                        date: match.dateFormatted
                    ),
                    homeViewModel: .init(
                        title: match.homeTeam,
                        imageUrl: imagesUrls.home,
                        status: match.winner == nil ? .idle : match.winner == match.homeTeam ? .winner : .loser
                    ),
                    awayViewModel: .init(
                        title: match.awayTeam,
                        imageUrl: imagesUrls.away,
                        status: match.winner == nil ? .idle : match.winner == match.awayTeam ? .winner : .loser
                    )
                )
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
