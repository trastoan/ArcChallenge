//
//  RootRouter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    static func presentTabBarController(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = ApplicationTabBarController()
    }
}
