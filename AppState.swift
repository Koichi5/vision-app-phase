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
    
    public var planetModels = [
        PlanetModel(name: "Earth", modelName: "Earth"),
        PlanetModel(name: "Jupiter", modelName: "Jupiter"),
        PlanetModel(name: "Mars", modelName: "Mars"),
        PlanetModel(name: "Mercury", modelName: "Mercury"),
        PlanetModel(name: "Moon", modelName: "Moon"),
        PlanetModel(name: "Neptune", modelName: "Neptune"),
        PlanetModel(name: "Pluto", modelName: "Pluto"),
        PlanetModel(name: "Saturn", modelName: "Saturn"),
        PlanetModel(name: "Sun", modelName: "Sun"),
        PlanetModel(name: "Uranus", modelName: "Uranus"),
        PlanetModel(name: "Venus", modelName: "Venus"),
    ]
    var phase: AppPhase = .startingUp
    
    var isImmersiveViewShown: Bool = false
    init () {
        Task.detached(priority: .high) {
            await self.loadModels()
        }
    }
}

public class PlanetModel {
    public var name: String
    public var modelName: String
    
    init(name: String,
         modelName: String) {
        self.name = name
        self.id = UUID()
        self.modelName = modelName
    }
    
    /// Calcualate ID based on name, which must be unique.
    public var id: UUID
}
