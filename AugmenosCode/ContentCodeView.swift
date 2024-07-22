//
//  ContentCodeView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI

struct ContentCodeView: View {
    var body: some View {
        Text("""
import SwiftUI

struct ContentView: View {
    @Environment(\\.openURL) var openURL
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    
                    Text("This simple app showcases some of visionOS capabilities with open source code. Experience the samples interactively in-app and view the code alongside them. Intended for developers learning visionOS.")

                    Spacer()
                    
                    Text("Select sample to begin:")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 30) {
                        NavigationLink(value: "Model3D") {
                            Label("Model3D", systemImage: "rotate.3d.fill")
                        }
                        
                        NavigationLink(value: "Volume") {
                            Label("Volume", systemImage: "cube.fill")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)
                    
                    HStack(alignment: .top, spacing: 30) {
                        VStack {
                            NavigationLink(value: "ImmersiveSpace") {
                                Label("Immersive Space", systemImage: "visionpro")
                            }
                            .disabled(true)
                            Text("Coming Soon")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        
                        NavigationLink(value: "HandTracking") {
                            Label("Hand Tracking", systemImage: "hand.raised.fingers.spread.fill")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)
                    
                    Spacer()
                    
                    Text("Learned something new? Please help others find this app by leaving a review! Complete source code on GitHub:")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 30) {
                        Button {
                            if let URL = URL(string: "https://apps.apple.com/app/id6544806836?action=write-review") {
                                UIApplication.shared.open(URL, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Label("Review", systemImage: "star.fill")
                        }
                        
                        Button {
                            if let URL = URL(string: "https://github.com/augmenos/AugmenosCode") {
                                UIApplication.shared.open(URL, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Label("GitHub", systemImage: "safari.fill")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 20)
                    
                    CopyrightView()
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
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "Model3D":
                    Model3DView()
                case "Volume":
                    VolumeContentView()
                case "HandTracking":
                    HandTrackingView()
                case "ImmersiveSpace":
                    Text("Immersive Space View")  // Placeholder
                default:
                    Text("Unknown Destination")
                }
            }
        }
        
    }
}

""")
        //                .foregroundStyle(.secondary)
        .fontDesign(.monospaced)
    }
}

