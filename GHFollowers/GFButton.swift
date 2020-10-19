//
//  GFButton.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/19/20.
//

import UIKit

class GFButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            layer.opacity = isHighlighted ? 0.8 : 1
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configureButton()
    }

    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        titleLabel?.textColor = .white
    }
}
