//
//  RootRouter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
import SwiftUI

class RootRouter: RootWireframe {
    static func presentTabBarController(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = defineRootController()
    }

    static func presentTabBarController() {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
                return
            }
            window.makeKeyAndVisible()
            window.rootViewController = ApplicationTabBarController()
        }
    }

    private static func defineRootController() -> UIViewController {
        return UserDefaults.authenticationEnabled ? GuardRouter.assembleModule() : ApplicationTabBarController()
    }
}
