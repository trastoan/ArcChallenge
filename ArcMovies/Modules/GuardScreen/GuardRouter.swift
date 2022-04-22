//
//  GuardRouter.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation
import UIKit

class GuardRouter {
    var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let controller = GuardViewController()
        let model = GuardViewModel()
        let router = GuardRouter()

        controller.model = model
        model.router = router
        router.viewController = controller

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.setTitleColor(.white)

        return nav
    }

    func dismissController() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
