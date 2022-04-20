//
//  SettingsView.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(UserDefaults.authenticationEnabledKey) private var toggleActive = false
    @AppStorage(UserDefaults.biometricEnabledKey) private var biometricsEnabled = false
    
    var body: some View {
        List {
            Section("Security") {
                Toggle("Activate app protection", isOn: $toggleActive)
                    .tint(Color(.navigationColor))
                if toggleActive {
                    Button {
                        if !biometricsEnabled {
                            AuthenticationService.shared.askForAuthentication { success in
                                biometricsEnabled = success
                            }
                        } else {
                            biometricsEnabled.toggle()
                        }
                    } label: {
                        Text("\(biometricsEnabled ? "Disable" : "Enable") Biometrics")
                    }
                    Button {
                        //enter pin
                    } label: {
                        Text("Change passcode")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
