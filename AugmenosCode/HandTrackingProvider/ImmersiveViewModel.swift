//
//  ImmersiveViewModel.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

/// Abstract: The class is designed to manage the RealityView within ImmersieView. It sets up an AR session with hand tracking and scene reconstruction capabilities.

import Foundation
import RealityKit
import ARKit

@MainActor class ImmersiveViewModel: ObservableObject {
    
    // Set up AR session and providers
    private let session = ARKitSession()
    private let handTracking = HandTrackingProvider()
    private let sceneReconstruction = SceneReconstructionProvider()
    
    // Main entity to hold all content
    private var contentEntity = Entity()
    
    // Dictionary to store mesh entities
    private var meshEntities = [UUID: ModelEntity]()
    
    // Create fingertip entities for both hands
    private let fingerEntities: [HandAnchor.Chirality: ModelEntity] = [
        .left: .createFingertip(),
        .right: .createFingertip()
    ]
    
    // Set up the main content entity
    func setupContentEntity() -> Entity {
        // Add fingertip entities to the main content entity
        for entity in fingerEntities.values {
            contentEntity.addChild(entity)
        }
        
        return contentEntity
    }
    
    // Start the AR session
    func runSession() async {
        do {
            try await session.run([sceneReconstruction, handTracking])
        } catch {
            print("Failed to start session: \(error)")
        }
    }
    
    // Process hand tracking updates
    func processHandUpdates() async {
        for await update in handTracking.anchorUpdates {
            let handAnchor = update.anchor
            guard handAnchor.isTracked else { continue }
            
            // Get the index fingertip joint
            let fingertip = handAnchor.handSkeleton?.joint(.indexFingerTip)
            guard ((fingertip?.isTracked) != nil) else { continue }
            
            // Calculate the transform for the fingertip
            let originFromWrist = handAnchor.originFromAnchorTransform
            guard let wristFromIndex = fingertip?.anchorFromJointTransform else { continue }
            let originFromIndex = originFromWrist * wristFromIndex
            
            // Update the position of the fingertip entity
            fingerEntities[handAnchor.chirality]?.setTransformMatrix(originFromIndex, relativeTo: nil)
        }
    }
    
    // Process scene reconstruction updates
    func processReconstructionUpdates() async {
        for await update in sceneReconstruction.anchorUpdates {
            let meshAnchor = update.anchor
            
            // Generate a mesh from the anchor
            guard let shape = try? await ShapeResource.generateStaticMesh(from: meshAnchor) else { continue }
            
            switch update.event {
            case .added:
                // Create and set up a new entity for the mesh
                let entity = ModelEntity()
                entity.transform = Transform(matrix: meshAnchor.originFromAnchorTransform)
                entity.collision = CollisionComponent(shapes: [shape], isStatic: true)
                entity.physicsBody = PhysicsBodyComponent()
                entity.components.set(InputTargetComponent())
                
                // Store and add the entity
                meshEntities[meshAnchor.id] = entity
                contentEntity.addChild(entity)
            case .updated:
                // Update an existing mesh entity
                guard let entity = meshEntities[meshAnchor.id] else { fatalError("Fatal Error") }
                entity.transform = Transform(matrix: meshAnchor.originFromAnchorTransform)
                entity.collision?.shapes = [shape]
            case .removed:
                // Remove a mesh entity
                meshEntities[meshAnchor.id]?.removeFromParent()
                meshEntities.removeValue(forKey: meshAnchor.id)
            }
        }
    }
    
    // Add a cube at the specified location
    func addCube(tapLocation: SIMD3<Float>) {
        let placementLocation = tapLocation + SIMD3<Float>(0, 0.2, 0)
        
        // Create a cube entity
        let entity = ModelEntity(
            mesh: .generateBox(size: 0.1, cornerRadius: 0.0),
            materials: [SimpleMaterial(color: .cyan, isMetallic: false)],
            collisionShape: .generateBox(size: SIMD3<Float>(repeating: 0.1)),
            mass: 1.0)
        
        // Set the cube's position and properties
        entity.setPosition(placementLocation, relativeTo: nil)
        entity.components.set(InputTargetComponent(allowedInputTypes: .all))
        
        // Add physics properties to the cube
        let material = PhysicsMaterialResource.generate(friction: 0.8, restitution: 0.0)
        entity.components.set(PhysicsBodyComponent(shapes: entity.collision!.shapes,
                                                   mass: 1.0,
                                                   material: material,
                                                   mode: .dynamic))
        
        // Add the cube to the scene
        contentEntity.addChild(entity)
    }
}
