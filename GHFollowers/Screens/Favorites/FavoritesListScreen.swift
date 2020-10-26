//
//  FavoritesListScreen.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/19/20.
//

import UIKit

class FavoritesListScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        PersistenceManager.retrieveFavorites { result in
//            guard let self = self else { return }

            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print(error)
            }
        }
    }
}
