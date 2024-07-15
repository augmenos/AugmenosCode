//
//  HandTrackingView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

/// **IMPORTANT:**  Add NSHandsTrackingUsageDescription and NSWorldSensingUsageDescription to Info.plist to enable tracking.

import SwiftUI
import RealityKit
import RealityKitContent

struct HandTrackingView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    var body: some View {
        
        HStack(spacing: 30) {
            // Left Column
            VStack(alignment: .leading) {
                Text("HandTrackingProvider")
                    .font(.extraLargeTitle)
                    .padding(.bottom, 30)
                
                Text("A source of live data about the position of a person’s hands and hand joints.")
                    .padding(.bottom, 20)
                                
                HStack(alignment: .top, spacing: 30) {
                    Image(systemName: "exclamationmark.bubble.fill")
                        .font(.largeTitle)
                    
                    Text("HandTrackingProvider requires both a Full Space and user permission with NSHandsTrackingUsageDescription in Info.plist.")
                        .multilineTextAlignment(.leading)
                }
                .padding(.bottom, 20)
                
                HStack(alignment: .top, spacing: 30) {
                    Image(systemName: "x.circle.fill")
                        .font(.largeTitle)
                    
                    Text("Warning: HandTrackingProvider will not work on the simulator. The app will crash!")
                        .multilineTextAlignment(.leading)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                Text("Here we have a toggle that will open the mixed full space to use HandTrackingProvider using .onChange(of: showImmersiveSpace):")
                    .padding(.bottom, 20)

                HStack(alignment: .center) {
                    
                    Toggle("Mixed Immersive Space", isOn: $showImmersiveSpace)
                        .padding()
                        .frame(width: 300)
                        .background(.thinMaterial)
                        .glassBackgroundEffect()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                // Footer
                Text("Learn more about HandTrackingProvider:")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 10)
                
                HStack(spacing: 30) {
                    
                    // Documentation URL
                    Button{
                        if let URL = URL(string: "https://developer.apple.com/documentation/arkit/handtrackingprovider") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" Apple Documentation", systemImage: "doc.text.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                    // Video URL
                    Button{
                        if let URL = URL(string: "https://developer.apple.com/videos/play/wwdc2024/10100/") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" WWDC Video", systemImage: "play.rectangle.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                }

                
            }
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task {
                    if newValue {
                        switch await openImmersiveSpace(id: "MixedImmersiveSpace") {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            fallthrough
                        @unknown default:
                            immersiveSpaceIsShown = false
                            showImmersiveSpace = false
                        }
                    } else if immersiveSpaceIsShown {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                }
            }
            .frame(maxWidth: 500)
            .padding()
            
            // Right Column
            VStack {
                ScrollView {
                    HandTrackingCodeView()
                }
            }
            .padding(30)
            .background(.thickMaterial)
            .cornerRadius(30)
        }
        .padding(40)
    }
}
