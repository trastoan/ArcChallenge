//
//  SettingsView.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var model: SettingsViewModel

    init(with model: SettingsViewModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section("Security") {
                Toggle("Activate app protection", isOn: $model.guardEnabled)
                    .tint(Color(.navigationColor))
                if model.guardEnabled {
                    Button {
                        model.changeBiometricStatus()
                    } label: {
                        Text("\(model.biometricsEnabled ? "Disable" : "Enable") Biometrics")
                    }
                    Button {
                        model.registerNewPin()
                    } label: {
                        Text("Change passcode")
                    }
                }
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
