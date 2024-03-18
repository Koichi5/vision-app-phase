//
//  AppState.swift
//  AppPhaseSample
//
//  Created by Koichi Kishimoto on 2024/03/17.
//

import Foundation

@Observable
@MainActor
public class AppState {
    var phase: AppPhase = .startingUp
    
    var isImmersiveViewShown: Bool = false
    init () {}
}
