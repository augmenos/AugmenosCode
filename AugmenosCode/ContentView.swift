//
//  ContentView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        
        HStack(spacing: 50) {
            
            // Left Column
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Image("AugmenosDeveloper_AppIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Augmenos")
                            .font(.extraLargeTitle)
                        Text("Code")
                            .font(.extraLargeTitle)
                    }
                }
                .padding(.bottom, 30)
                                
                Text("This simple app showcases some of visionOS capabilities with open source code. Experience the samples interactively in-app and view the code alongside them. Intended for developers new to visionOS.")
                                              
                Spacer()

                Text("Select sample to begin:")
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
                .disabled(true)
                .frame(maxWidth: .infinity, alignment: .center)

                Text("Coming Soon")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text("Complete source code and downloadable project on GitHub:")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 20)
                
                HStack(spacing: 30) {
                    
                    // About Sheet
                    Button{
                        if let URL = URL(string: "https://www.augmenos.com/about") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label("About", systemImage: "info.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                    // GitHub URL
                    Button{
                        if let URL = URL(string: "https://github.com/augmenos") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label("GitHub", systemImage: "safari.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
            .frame(maxWidth: 500)
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
