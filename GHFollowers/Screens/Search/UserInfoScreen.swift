//
//  UserInfoScreen.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/22/20.
//

import UIKit

class UserInfoScreen: UIViewController {
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
    }

    @objc private func dismissScreen() {
        dismiss(animated: true)
    }
}
