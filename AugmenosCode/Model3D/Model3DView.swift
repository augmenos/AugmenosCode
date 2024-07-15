//
//  Model3DView.swift
//  AugmenosCode
//
//  Created by Miguel Garcia Gonzalez on 7/15/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Model3DView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        
        HStack(spacing: 50) {
            // Left Column
            VStack(alignment: .leading) {
                Text("Model3D")
                    .font(.extraLargeTitle)
                    .padding(.bottom, 30)
                
                Text("A view that asynchronously loads and displays a 3D model.")
                    .padding(.bottom, 20)
                                
                HStack(alignment: .top, spacing: 30) {
                    Image(systemName: "exclamationmark.bubble.fill")
                        .font(.largeTitle)
                    
                    Text("Model3D is a SwiftUI view to quickly render a 3D model. ModelEntity is a more robost representation of a physical object that RealityKit renders and optionally simulates for advanced functionality.")
                        .multilineTextAlignment(.leading)
                }
                .padding(.bottom, 20)

                Spacer()
                
                Text("Here we load and display scene \"Heart\" from RealityKitContent:")
                    .padding(.bottom, 50)
                
                HStack(alignment: .center) {
                    
                    // "Human Heart" by sv1nks is licensed under Creative Commons Attribution.
                    Model3D(named: "Heart", bundle: realityKitContentBundle) { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .dragRotation()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                
                // Footer
                Text("Learn more about Model3D:")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 10)
                
                HStack(spacing: 30) {
                    
                    // Documentation URL
                    Button{
                        if let URL = URL(string: "https://developer.apple.com/documentation/realitykit/model3d") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" Apple Documentation", systemImage: "doc.text.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                    // Video URL
                    Button{
                        if let URL = URL(string: "https://developer.apple.com/videos/play/wwdc2023/10113/") {
                            UIApplication.shared.open(URL, options: [:], completionHandler: nil) }
                    } label: {
                        Label(" WWDC Video", systemImage: "play.rectangle.fill")
                            .foregroundStyle(.secondary)
                    }
                    
                }
                
            }
            .frame(maxWidth: 500)
            .padding()
            
            // Right Column
            VStack {
                ScrollView {
                    Model3DCodeView()
                }
            }
            .padding(30)
            .background(.thickMaterial)
            .cornerRadius(30)
            
        }
        .padding(40)
    }
}
