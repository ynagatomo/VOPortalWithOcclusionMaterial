//
//  occlusionMaterialVOApp.swift
//  occlusionMaterialVO
//
//  Created by Yasuhito Nagatomo on 2023/08/01.
//

import SwiftUI

@main
struct occlusionMaterialVOApp: App {
    @State private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }

        ImmersiveSpace(id: "anotherWorld") {
            ImmersiveView(viewModel: viewModel)
        }
    }
}
