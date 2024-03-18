//
//  AppPhaseSampleApp.swift
//  AppPhaseSample
//
//  Created by Koichi Kishimoto on 2024/03/17.
//

import SwiftUI
import RealityKit

// This app is for App phase leaning.
@main
@MainActor
struct AppPhaseSampleApp: App {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var appState = AppState()
    
    var body: some SwiftUI.Scene {
        WindowGroup("Main") {
            ContentView()
                .environment(appState)
                .onChange(of: appState.phase.isImmmersed) { _, showMRView in
                    if showMRView {
                        Task {
                            appState.isImmersiveViewShown = true
                            await openImmersiveSpace(id: "ImmersiveSpace")
                            dismissWindow(id: "Main")
                        }
                    }
                }
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(appState)
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
    
    init() {}
}
