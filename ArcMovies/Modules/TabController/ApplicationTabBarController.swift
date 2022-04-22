//
//  ApplicationTabBarController.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class ApplicationTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()

        let upcomingController = UpcomingMoviesRouter.assembleModule()
        let searchController = MovieSearchRouter.assembleModule()
        
        upcomingController.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "calendar"), tag: 1)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let tabBarControllers = [upcomingController, searchController]
        self.setViewControllers(tabBarControllers, animated: true)
    }

    func setupAppearence() {
        tabBar.backgroundColor = .systemBackground
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .navigationColor
    }
}
