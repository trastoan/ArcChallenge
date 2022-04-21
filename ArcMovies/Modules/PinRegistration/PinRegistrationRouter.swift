//
//  PinRegistrationRouter.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class PinRegistrationRouter {
    var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let controller = PinRegistrationViewController()
        let model = PinRegistrationViewModel()
        let router = PinRegistrationRouter()

        router.viewController = controller
        model.router = router
        controller.model = model

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen

        return nav
    }

    func dismissController() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
