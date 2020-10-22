//
//  FollowerListScreen.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/19/20.
//

import UIKit

class FollowerListScreen: UIViewController {
    // MARK: - Properties

    enum Section { case main }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    var username: String!
    var followers = [Follower]()
    var page = 1
    var hasMoreFollowers = true

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Defined methods

    private func configureScreen() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }

    private func getFollowers() {
        showLoadingView()

        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)

                // Shows an empty state view if no followers have been found
                if followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                } else {
                    self.updateData()
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) {
            collectionView, indexPath, follower -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

// MARK: - Collection view methods

extension FollowerListScreen: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreFollowers else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            page += 1
            getFollowers()
        }
    }
}
