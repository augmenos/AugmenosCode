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
struct ContentView: View {
    @Environment(\\.openWindow) private var openWindow
    @Environment(\\.dismissWindow) private var dismissWindow

    var body: some View {
        
        HStack(spacing: 50) {
            
            // Left Column
            VStack(alignment: .leading) {
                
                HStack {
                    Image("AugmenosDeveloper_AppIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Augmenos")
                            .font(.extraLargeTitle)
                        Text("Developer")
                            .font(.largeTitle)
                    }
                }
                .padding(.bottom, 30)
                                
                Text("This simple app showcases some of visionOS capabilities. Experience the examples interactively within the app and view the source code alongside them. Intended for beginners to visionOS.")
                                              
                Spacer()

                Text("Select sample to begin learning:")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)

                HStack(spacing: 30) {
                    
                    // Open Model3D Sample
                    Button{
                        openWindow(id: "Model3D")
                    } label: {
                        Label("Model 3D", systemImage: "rotate.3d.fill")
                    }
                    
                    // Open HandTracking Sample
                    Button{
                        openWindow(id: "HandTracking")
                    } label: {
                        Label("Hand Tracking", systemImage: "hand.raised.fingers.spread.fill")
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)

                
                // Open Immersive Space Sample
                Button{
                    openWindow(id: "HandTracking")
                } label: {
                    Label("Immersive Space", systemImage: "visionpro")
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                
                Text("Complete source code and downloadable project on GitHub.")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 20)
                
                HStack(spacing: 30) {
                    
                    // Open About Sheet
                    Button{
                        openWindow(id: "Model3D")
                    } label: {
                        Label("About", systemImage: "info.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                    // Open Safari, GitHub URL
                    Button{
                        openWindow(id: "HandTracking")
                    } label: {
                        Label("GitHub", systemImage: "safari.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
            .padding()
            
            // Right Column
            VStack {
                ScrollView {
                    ContentCodeView()
                }
            }
            .padding(30)
            .background(.thickMaterial)
            .cornerRadius(30)

        }
        .padding(40)
    }
}

""")
        //                .foregroundStyle(.secondary)
        .fontDesign(.monospaced)
    }
}

