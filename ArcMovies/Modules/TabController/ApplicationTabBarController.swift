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
        
        let upcomingController = UpcomingMoviesRouter.assembleModule()
        let searchController = MovieSearchRouter.assembleModule()
        
        upcomingController.tabBarItem = UITabBarItem(title: "Upcoming", image: #imageLiteral(resourceName: "upcomingTab"), tag: 1)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "searchIcon"), tag: 2)
        
        let tabBarControllers = [upcomingController, searchController]
        self.setViewControllers(tabBarControllers, animated: true)
    }
}
