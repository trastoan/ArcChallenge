//
//  UIImageExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
import Nuke


class LoadableImageView: UIImageView {
    let loadingIndicator = UIActivityIndicatorView()

    override init(image: UIImage?) {
        super.init(image: image)
        loadingIndicator.setupOn(view: self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadingIndicator.setupOn(view: self)
    }
}

extension LoadableImageView {

    func loadImage(withURL url: URL?, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {

        loadingIndicator.startAnimating()
        Nuke.cancelRequest(for: self)
        self.image = nil

        guard let imageURL = url else {
            loadingIndicator.stopAnimating()
            self.image = defaultImage
            return
        }

        Nuke.loadImage(with: imageURL, into: self) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
                case .success(let response):
                    self.image = response.image
                case .failure:
                    self.image = defaultImage
            }
        }
    }
}
