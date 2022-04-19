//
//  SettingsView.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("authenticationEnabled") private var toggleActive = false
    var body: some View {
        List {
            Section("Security") {
                Toggle("Activate app protection", isOn: $toggleActive)
                    .tint(Color(.navigationColor))
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
