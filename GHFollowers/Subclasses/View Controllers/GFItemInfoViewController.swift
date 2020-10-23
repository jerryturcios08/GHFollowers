//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/23/20.
//

import UIKit

class GFItemInfoViewController: UIViewController {
    // MARK: - Properties

    let stackView = UIStackView()
    let firstItemInfoView = GFItemInfoView()
    let secondItemInfoView = GFItemInfoView()
    let actionButton = GFButton()

    let padding: CGFloat = 20

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureStackView()
        configureActionButton()
    }

    // MARK: - Defined methods

    private func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
    }

    private func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureActionButton() {
        view.addSubview(actionButton)

        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
