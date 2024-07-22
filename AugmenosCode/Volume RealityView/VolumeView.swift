//
//  VolumeView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/22/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct VolumeView: View {
    @State var enlarge = false

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                // "#SculptJanuary19 - Day03 Chest" by Bohdan Lvov is licensed under Creative Commons Attribution
                if let scene = try? await Entity(named: "Chest", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 2.0 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in // Be sure to add 
                enlarge.toggle()
            })

            VStack {
                Toggle("Enlarge RealityView Content", isOn: $enlarge)
                    .toggleStyle(.button)
            }
            .glassBackgroundEffect()
        }
    }
}
