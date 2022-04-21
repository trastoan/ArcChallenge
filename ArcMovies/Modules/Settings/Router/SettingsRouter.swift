//
//  SettingsRouter.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsRouter {
    var viewController: UIViewController?

    static func assembleModule() -> UIHostingController<SettingsView> {
        let model = SettingsViewModel()
        let router = SettingsRouter()
        let view = SettingsView(with: model)
        let controller = UIHostingController(rootView: view)

        controller.title = "Configurations"
        controller.preferLargeTitles(isOn: false)

        model.router = router
        router.viewController = controller

        return controller
    }

    func registerNewPin() {
        let destination = PinRegistrationRouter.assembleModule()
        viewController?.present(destination, animated: true)
    }
}
