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

    static func presentEntryController(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = ApplicationTabBarController()
        presentGuardController(in: window)
    }

    static func presentGuardController(in window: UIWindow) {
        if UserDefaults.authenticationEnabled {
            guard let topController = window.rootViewController as? UITabBarController else {
                return
            }

            let nav = GuardRouter.assembleModule()
            topController.selectedViewController?.present(nav, animated: true)
        }
    }
}
