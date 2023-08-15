//
//  ContentView.swift
//  occlusionMaterialVO
//
//  Created by Yasuhito Nagatomo on 2023/08/01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var viewModel: ViewModel

    @State private var showImmersiveSpace = false
    @State private var worldName = ViewModel.WorldName.church
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Enter another worlds!").font(.title)

            Picker("World Name", selection: $worldName) {
                ForEach(ViewModel.WorldName.allCases) { name in
                    Text(name.rawValue).tag(name)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: worldName) { _, _ in
                viewModel.change(world: worldName)
            }

            Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 50)
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "anotherWorld")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}


@Observable
final class ViewModel {
    enum WorldName: String, CaseIterable, Identifiable {
        case church
        case umbrellas
        var id: String { rawValue }
    }
    var currentWorld = WorldName.church

    func change(world: WorldName) {
        currentWorld = world
        print("Current world was changed \(currentWorld)")
    }
    func worldTextureName() -> String {
        switch currentWorld {
        case .church:
            "christmas_photo_studio_05_4k"
        case .umbrellas:
            "outdoor_umbrellas_4k"
        }
    }
}
