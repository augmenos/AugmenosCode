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
        
        WindowGroup(id: "HandTracking") {
            HandTrackingView()
        }
        
        ImmersiveSpace(id: "MixedImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $immersionState, in: .mixed)
        .upperLimbVisibility(.hidden)

        WindowGroup(id: "Model3D") {
            Model3DView()
        }
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
