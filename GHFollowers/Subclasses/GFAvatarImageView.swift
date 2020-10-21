//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Jerry Turcios on 10/21/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }

    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }

        guard let url = URL(string: urlString) else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Leave function if there is an error; use placeholder instead
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }

            // If image is available, then cache it
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async { self.image = image }
        }

        dataTask.resume()
    }
}
