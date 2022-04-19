//
//  SettingsRouter.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation
import SwiftUI
class SettingsRouter {
    static func assembleModule() -> UIHostingController<SettingsView> {
        let controller = UIHostingController(rootView: SettingsView())
        controller.title = "Configurations"
        controller.preferLargeTitles(isOn: false)
        return controller
    }
}
