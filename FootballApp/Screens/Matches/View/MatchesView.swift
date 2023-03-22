//
//  MatchesView.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class MatchesView: UIView {

    // MARK: - Properties
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: generateLayout()
        )
        view.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.identifier
        )
        view.register(
            MatchCell.self,
            forCellWithReuseIdentifier: MatchCell.identifier
        )
        view.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.identifier
        )
        view.keyboardDismissMode = .onDrag
        return view
    }()

    private(set) lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.autocorrectionType = .no
        view.placeholder = Localizable.search.localized
        view.showsCancelButton = true
        view.returnKeyType = .search
        return view
    }()

    // MARK: - UI Properties
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
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
extension MatchesView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews(
            collectionView,
            activityIndicatorView,
            searchBar
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}

// MARK: - Internal methods
extension MatchesView {
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        collectionView.isHidden = true
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.collectionView.alpha = 0
        }

        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func stopLoading() {
        collectionView.isUserInteractionEnabled = true
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.collectionView.alpha = 1
        }

        activityIndicatorView.isHidden = true
    }
}

// MARK: - Private methods
private extension MatchesView {
    func generateLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(250)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: size,
            repeatingSubitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)

        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [sectionHeader]

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        section.interGroupSpacing = 16
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
