//
//  ImmersiveView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

/// Abstract: This SwiftUI view creates spatial interface using RealityView, integrating RealityKit content and enabling user interactions like spatial taps to add 3D objects in the AR space.

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    // Create and manage the view model as a state object
    @StateObject var model = ImmersiveViewModel()

    var body: some View {
        // RealityView is used to integrate RealityKit content into SwiftUI
        RealityView { content in
            // Add the main content entity to the RealityView
            content.add(model.setupContentEntity())
        }
        // Start the AR session when the view appears
        .task {
            await model.runSession()
        }
        // Process hand tracking updates continuously
        .task {
            await model.processHandUpdates()
        }
        // Process scene reconstruction updates continuously
        .task {
            await model.processReconstructionUpdates()
        }
        // Add a spatial tap gesture recognizer
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in
            // Convert the tap location from global to scene coordinates
            let location3D = value.convert(value.location3D, from: .global, to: .scene)
            // Add a cube at the tapped location
            model.addCube(tapLocation: location3D)
        }))
    }
}
