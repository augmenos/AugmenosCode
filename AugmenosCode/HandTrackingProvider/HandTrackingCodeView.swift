//
//  HandTrackingCodeView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI

struct HandTrackingCodeView: View {
    var body: some View {
        Text("""
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

@MainActor class ImmersiveViewModel: ObservableObject {
    
    private let session = ARKitSession()
    private let handTracking = HandTrackingProvider()
    private let sceneReconstruction = SceneReconstructionProvider()
    
    private var contentEntity = Entity()
    
    private var meshEntities = [UUID: ModelEntity]()
    
    private let fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
        .left: .createFingertip(),
        .right: .createFingertip()
    ]
    
    func setupContentEntity() -> Entity {
        for entity in fingerEntities.values {
            contentEntity.addChild(entity)
        }
        
        return contentEntity
    }
    
    func runSession() async {
        do {
            try await session.run([sceneReconstruction, handTracking])
        } catch {
            print("Failed to start session: \\(error)")
        }
        
    }
    
    func processHandUpdates() async {
        for await update in handTracking.anchorUpdates {
            let handAnchor = update.anchor
            guard handAnchor.isTracked else { continue }
            
            let fingertip = handAnchor.handSkeleton?.joint(.indexFingerTip)
            guard ((fingertip?.isTracked) != nil) else { continue }
            
            let originFromWrist = handAnchor.originFromAnchorTransform
            guard let wristFromIndex = fingertip?.anchorFromJointTransform else { continue }
            let originFromIndex = originFromWrist * wristFromIndex
            
            fingerEntities[handAnchor.chirality]?.setTransformMatrix(originFromIndex, relativeTo: nil)
        }
    }

""")
        .fontDesign(.monospaced)
    }
}
