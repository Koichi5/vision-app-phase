//
//  AppState+Phases.swift
//  AppPhaseSample
//
//  Created by Koichi Kishimoto on 2024/03/17.
//

import Foundation

extension AppState {
    public func finishedStartingUp() {
        phase.transition(to: .loadingAssets)
    }
    
    public func finishedLoadingAssets() {
        phase.transition(to: .home)
    }
    
    public func openImmersiveView() {
        phase.transition(to: .immersiveView)
    }
}
