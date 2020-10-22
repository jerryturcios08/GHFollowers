//
//  UserInfoScreen.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/22/20.
//

import UIKit

class UserInfoScreen: UIViewController {
    let headerView = UIView()

    private var username: String

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissScreen))
        navigationItem.rightBarButtonItem = doneButton

        configureHeaderView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                self.addChildViewControllers(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }

    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

    private func addChildViewControllers(user: User) {
        DispatchQueue.main.async {
            self.add(GFUserInfoHeaderViewController(user: user), to: self.headerView)
        }
    }

    private func add(_ childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }

    @objc private func dismissScreen() {
        dismiss(animated: true)
    }
}
