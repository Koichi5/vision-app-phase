//
//  AppState+ModelLoading.swift
//  AppPhaseSample
//
//  Created by Koichi Kishimoto on 2024/03/20.
//

import SwiftUI
import RealityKit
import RealityKitContent

actor EntityContainer {
    var entity: Entity?
    func setEntity(_ newEntity: Entity?) {
        entity = newEntity
    }
}

struct LoadResult: Sendable {
    var entity: Entity
    var key: String
}

extension AppState {
    private func loadFromRCPro(named entityName: String, fromSceneNamed sceneName: String, scaleFactor: Float? = nil, positionFactor: SIMD3<Float>? = nil) async throws -> Entity? {
        var ret: Entity? = nil
        logger.info("Loading entity \(entityName) from Reality Composer Pro scene \(sceneName)")
        do {
            let scene = try await Entity(named: sceneName, in: realityKitContentBundle)
            let entityContainer = EntityContainer()
            let theRet = scene.findEntity(named: entityName)
            if scaleFactor != nil {
                logger.info("scale factor is: \(scaleFactor!)")
                theRet?.scale = SIMD3<Float>(repeating: scaleFactor!)
            }
            if positionFactor != nil {
                logger.info("position factor is: \(positionFactor!)")
                theRet?.position = positionFactor!
            }
            await entityContainer.setEntity(theRet)
            ret = await entityContainer.entity
        } catch {
            fatalError("\tEncountered fatal error: \(error.localizedDescription)")
        }
        return ret
    }
    
    public func loadModels() async {
        defer {
            finishedLoadingModels()
        }
        let startTime = Date.timeIntervalSinceReferenceDate
        logger.info("Starting load from Reality Composer Pro Project.")
        finishedStartingUp()
        await withTaskGroup(of: LoadResult.self) { taskGroup in
            loadEarthModel(taskGroup: &taskGroup) // load earth scene model
            loadPlanetModels(taskGroup: &taskGroup) // load planets scene models
        }
        logger.info("Load of pieces completed. Duration: \(Date.timeIntervalSinceReferenceDate - startTime)")
    }
    
    private func loadEarthModel(taskGroup: inout TaskGroup<LoadResult>) {
        taskGroup.addTask {
            var result: Entity? = nil
            do {
                logger.info("Loading earth model.")
                if let earthModel = try await self.loadFromRCPro(named: earthModelName, fromSceneNamed: earthSceneName) {
                    result = earthModel
                }
            } catch {
                fatalError("Attempted to load goal entity but failed: \(error.localizedDescription)")
            }
            guard let result = result else {
                fatalError("Loaded earth model is nil.")
            }
            return LoadResult(entity: result, key: earthModelName)
        }
    }
    
    private func loadPlanetModels(taskGroup: inout TaskGroup<LoadResult>) {
//        logger.info("Loading planet models.")
//        
//        for planet in planetModels {
//            taskGroup.addTask {
//                do {
//                    guard let planetEntity = try await self.loadFromRCPro(named: planet.modelName, fromSceneNamed: planetsSceneName) else {
//                        fatalError("Attempted to load planet entity \(planet.name) but failed.")
//                    }
//                    return LoadResult(entity: planetEntity, key: planet.name)
//                } catch {
//                    fatalError("Attempted to load \(planet.name) but failed: \(error.localizedDescription)")
//                }
//            }
//        }
    }
}
