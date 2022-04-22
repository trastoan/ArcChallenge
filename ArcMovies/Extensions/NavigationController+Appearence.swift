//
//  NavigationController+Appearence.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setAppearence(background: UIColor, tint: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = background
        appearence.shadowColor = .clear
        appearence.titleTextAttributes = [.foregroundColor : tint]
        appearence.largeTitleTextAttributes = [.foregroundColor : tint]

        navigationBar.standardAppearance = appearence
        navigationBar.tintColor = tint
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }

    func setTitleColor(_ color: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.titleTextAttributes = [.foregroundColor : color]
        appearence.largeTitleTextAttributes = [.foregroundColor : color]

        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
