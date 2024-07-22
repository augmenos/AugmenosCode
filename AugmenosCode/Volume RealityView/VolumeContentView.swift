//
//  VolumeContentView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/22/24.
//

import SwiftUI

struct VolumeContentView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var showVolume = false
    @State private var volumeShown = false
    
    var body: some View {
        
        HStack(spacing: 30) {
            // Left Column
            VStack(alignment: .leading) {
                Text("Volume RealityView")
                    .font(.extraLargeTitle)
                    .padding(.bottom, 30)
                
                Text("A view that contains RealityKit content. Use RealityView to display rich 3D content using RealityKit in your app, including RealityKit content authored in Reality Composer Pro.")
                    .padding(.bottom, 20)
                
                HStack(alignment: .top, spacing: 30) {
                    Image(systemName: "exclamationmark.bubble.fill")
                        .font(.largeTitle)
                    
                    Text("Review Model3D first, which is a simpler method of loading and presenting 3D models without RealityView.")
                        .multilineTextAlignment(.leading)
                }
                .padding(.bottom, 20)
                
                HStack(alignment: .top, spacing: 30) {
                    Image(systemName: "exclamationmark.bubble.fill")
                        .font(.largeTitle)
                    
                    Text("Be sure to add Collision and Input Target to model in RCP in order to recognize TapGesture().")
                        .multilineTextAlignment(.leading)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                Text("Here we have a toggle button that will open the Volume from WindowGroup(id: \"VolumeContent\")")
                    .padding(.bottom, 20)
                
                HStack(alignment: .center) {
                    Toggle(volumeShown ? "Hide Volume" : "Show Volume", isOn: $showVolume)
                        .padding()
                        .toggleStyle(.button)
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
                        if let URL = URL(string: "https://developer.apple.com/documentation/realitykit/realityview") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" Apple Documentation", systemImage: "doc.text.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                    // Video URL
                    Button{
                        if let URL = URL(string: "https://developer.apple.com/videos/play/wwdc2024/10153/") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" WWDC Video", systemImage: "play.rectangle.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                
                
            }
            .onChange(of: showVolume) { _, newValue in
                if newValue {
                    openWindow(id: "Volume")
                    volumeShown = true
                } else {
                    dismissWindow(id: "Volume")
                    volumeShown = false
                }
            }
            .frame(maxWidth: 500)
            .padding()
            
            // Right Column
            VStack {
                ScrollView {
                    VolumeCodeView()
                }
            }
            .padding(30)
            .background(.thickMaterial)
            .cornerRadius(30)
        }
        .padding(40)
    }
}
