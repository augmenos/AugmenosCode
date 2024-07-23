//
//  AugmenosCodeApp.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI

@main
struct AugmenosCodeApp: App {
    @State private var immersionState: ImmersionStyle = .mixed

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1400, height: 800)
                
        WindowGroup(id: "Volume") {
            VolumeView()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "MixedImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $immersionState, in: .mixed)
        .upperLimbVisibility(.hidden)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
