//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/23/20.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .followers, withCount: user.followers)
        secondItemInfoView.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
