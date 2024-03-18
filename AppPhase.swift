//
//  AppPhase.swift
//  AppPhaseSample
//
//  Created by Koichi Kishimoto on 2024/03/17.
//

import Foundation
import OSLog

public enum AppPhase: String, Codable, Sendable, Equatable {
    case startingUp
    case loadingAssets
    case home
    case immersiveView
    
    var isImmmersed: Bool {
        switch self {
        case .startingUp, .loadingAssets, .home:
            return false
        case .immersiveView:
            return true
        }
    }
    
    @discardableResult
    mutating public func transition(to newPhase: AppPhase) -> Bool {
        logger.info("Phase change to \(newPhase.rawValue)")
        guard self != newPhase else {
            logger.debug("Attempting to change phase to \(newPhase.rawValue) but already in that state. Treating as no-op.")
            return false
        }
        self = newPhase
        return true
    }
}

let logger = Logger()
