//
//  ImmersiveView.swift
//  occlusionMaterialVO
//
//  Created by Yasuhito Nagatomo on 2023/08/01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var viewModel: ViewModel
    @State private var doomEntity: ModelEntity!

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "anotherWorld", in: realityKitContentBundle) {
                content.add(scene)
                print("scene = \(scene)")


                if let doom = scene.findEntity(named: "Doom") as? ModelEntity {
                    doomEntity = doom
                    if let textureResource = try? await TextureResource(named: viewModel.worldTextureName()) {
                        var material = UnlitMaterial()
                        material.color.texture = PhysicallyBasedMaterial.Texture(textureResource)
                        doom.model?.materials = [material]
                    }
                }

                if let occluder = scene.findEntity(named: "Occluder") as? ModelEntity {
                    let material = OcclusionMaterial()
                    occluder.model?.materials = [material]
                }
            }
        } update: { content in
            print("Update: texture = \(viewModel.worldTextureName())")
            Task {
                if let textureResource = try? await TextureResource(named: viewModel.worldTextureName()) {
                    var material = UnlitMaterial()
                    material.color.texture = PhysicallyBasedMaterial.Texture(textureResource)
                    doomEntity.model?.materials = [material]
                }
            }
        }
    }
}

#Preview {
    ImmersiveView(viewModel: ViewModel())
        .previewLayout(.sizeThatFits)
}
