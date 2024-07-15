//
//  AugmenosCodeApp.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI

@main
struct AugmenosCodeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
