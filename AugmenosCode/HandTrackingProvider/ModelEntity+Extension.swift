//
//  ModelEntity+Extension.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

/// Abstract: This extension adds functionality to ModelEntity for creating a visual representation of a fingertip in an AR environment (a cyan sphere).

import Foundation
import RealityKit
import ARKit

extension ModelEntity {
    
    class func createFingertip() -> ModelEntity {
        // Create a small, cyan sphere to represent the fingertip
        let entity = ModelEntity(
            mesh: .generateSphere(radius: 0.005),  // 5mm radius sphere
            materials: [UnlitMaterial(color: .cyan)],  // Cyan color, unlit material
            collisionShape: .generateSphere(radius: 0.005),  // Collision shape matching the visual
            mass: 0.0)  // No mass, as this is just a visual representation
        
        // Set the physics body to kinematic mode
        // This allows the entity to be moved programmatically without being affected by physics
        entity.components.set(PhysicsBodyComponent(mode: .kinematic))
        
        // Set the opacity to fully opaque
        entity.components.set(OpacityComponent(opacity: 1.0))
        
        return entity
    }
    
}
