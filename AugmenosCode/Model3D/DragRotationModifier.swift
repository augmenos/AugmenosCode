/*
See Apple LICENSE at the end of this file for this code's licensing information.

Abstract:
A modifier for turning drag gestures into rotation.
*/

import SwiftUI
import RealityKit

extension View {
    /// Enables people to drag an entity to rotate it, with optional limitations
    /// on the rotation in yaw and pitch.
    func dragRotation(
        yawLimit: Angle? = nil,
        pitchLimit: Angle? = nil,
        sensitivity: Double = 10,
        axRotateClockwise: Bool = false,
        axRotateCounterClockwise: Bool = false
    ) -> some View {
        self.modifier(
            DragRotationModifier(
                yawLimit: yawLimit,
                pitchLimit: pitchLimit,
                sensitivity: sensitivity,
                axRotateClockwise: axRotateClockwise,
                axRotateCounterClockwise: axRotateCounterClockwise
            )
        )
    }
}

/// A modifier converts drag gestures into entity rotation.
private struct DragRotationModifier: ViewModifier {
    var yawLimit: Angle?
    var pitchLimit: Angle?
    var sensitivity: Double
    var axRotateClockwise: Bool
    var axRotateCounterClockwise: Bool

    @State private var baseYaw: Double = 0
    @State private var yaw: Double = 0
    @State private var basePitch: Double = 0
    @State private var pitch: Double = 0

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.radians(yaw == 0 ? 0.01 : yaw), axis: .y)
            .rotation3DEffect(.radians(pitch == 0 ? 0.01 : pitch), axis: .x)
            .gesture(DragGesture(minimumDistance: 0.0)
                .targetedToAnyEntity()
                .onChanged { value in
                    // Find the current linear displacement.
                    let location3D = value.convert(value.location3D, from: .local, to: .scene)
                    let startLocation3D = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let delta = location3D - startLocation3D

                    // Use an interactive spring animation that becomes
                    // a spring animation when the gesture ends below.
                    withAnimation(.interactiveSpring) {
                        yaw = spin(displacement: Double(delta.x), base: baseYaw, limit: yawLimit)
                        pitch = spin(displacement: Double(delta.y), base: basePitch, limit: pitchLimit)
                    }
                }
                .onEnded { value in
                    // Find the current and predicted final linear displacements.
                    let location3D = value.convert(value.location3D, from: .local, to: .scene)
                    let startLocation3D = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let predictedEndLocation3D = value.convert(value.predictedEndLocation3D, from: .local, to: .scene)
                    let delta = location3D - startLocation3D
                    let predictedDelta = predictedEndLocation3D - location3D

                    // Set the final spin value using a spring animation.
                    withAnimation(.spring) {
                        yaw = finalSpin(
                            displacement: Double(delta.x),
                            predictedDisplacement: Double(predictedDelta.x),
                            base: baseYaw,
                            limit: yawLimit)
                        pitch = finalSpin(
                            displacement: Double(delta.y),
                            predictedDisplacement: Double(predictedDelta.y),
                            base: basePitch,
                            limit: pitchLimit)
                    }

                    // Store the last value for use by the next gesture.
                    baseYaw = yaw
                    basePitch = pitch
                }
            )
            .onChange(of: axRotateClockwise) {
                withAnimation(.spring) {
                    yaw -= (.pi / 6)
                    baseYaw = yaw
                }
            }
            .onChange(of: axRotateCounterClockwise) {
                withAnimation(.spring) {
                    yaw += (.pi / 6)
                    baseYaw = yaw
                }
            }
    }

    /// Finds the spin for the specified linear displacement, subject to an
    /// optional limit.
    private func spin(
        displacement: Double,
        base: Double,
        limit: Angle?
    ) -> Double {
        if let limit {
            return atan(displacement * sensitivity) * (limit.degrees / 90)
        } else {
            return base + displacement * sensitivity
        }
    }

    /// Finds the final spin given the current and predicted final linear
    /// displacements, or zero when the spin is restricted.
    private func finalSpin(
        displacement: Double,
        predictedDisplacement: Double,
        base: Double,
        limit: Angle?
    ) -> Double {
        // If there is a spin limit, always return to zero spin at the end.
        guard limit == nil else { return 0 }

        // Find the projected final linear displacement, capped at 1 more revolution.
        let cap = .pi * 2.0 / sensitivity
        let delta = displacement + max(-cap, min(cap, predictedDisplacement))

        // Find the final spin.
        return base + delta * sensitivity
    }
}

//MARK: LICENSE DragRotationModifier.swift

/*
 
 Copyright (C) 2024 Apple Inc. All Rights Reserved.

 IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.

 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.

 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.

 
 */
