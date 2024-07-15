//
//  ImmersiveView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @StateObject var model = ImmersiveViewModel()

    var body: some View {
        RealityView { content in
            content.add(model.setupContentEntity())
        }
        .task {
            await model.runSession()
        }
        .task {
            await model.processHandUpdates()
        }
        .task {
            await model.processReconstructionUpdates()
        }
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded({ value in
            let location3D = value.convert(value.location3D, from: .global, to: .scene)
            model.addCube(tapLocation: location3D)
        }))
    }
}
