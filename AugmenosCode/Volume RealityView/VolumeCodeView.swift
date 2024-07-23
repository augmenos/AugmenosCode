//
//  VolumeCodeView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/22/24.
//

import SwiftUI

struct VolumeCodeView: View {
    var body: some View {
        Text("""
import SwiftUI
import RealityKit
import RealityKitContent

struct VolumeView: View {
    @State var enlarge = false

    var body: some View {
        VStack {
            RealityView { content in
                if let scene = try? await Entity(named: "Chest", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
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

""")
        .fontDesign(.monospaced)
    }
}

