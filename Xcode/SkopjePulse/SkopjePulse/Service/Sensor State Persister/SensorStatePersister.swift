//
//  SensorStatePersister.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation
import RealmSwift

class SensorStateObject: Object {
    @objc dynamic var sensorID: String = ""
    @objc dynamic var enabled: Bool = true
    
    override class func primaryKey() -> String? {
        return "sensorID"
    }
}

class SensorStatePersister {
    
    public static let shared = SensorStatePersister()
    private let realm = try! Realm()
    
    private init() { }
    
    enum RealmDatabaseError: Error {
        case recordExistInDatabase
        case noRecordsInDatabase
    }
    
    //  MARK: If record exist update it, if not insert new record
    public func insert(sensor: SensorStateObject) {
        if exists(sensor: sensor) {
            self.update(sensor: sensor)
        } else {
            try! realm.write {
                realm.add(sensor)
            }
        }        
    }
    
    public func update(sensor: SensorStateObject) {
        guard let query = realm.objects(SensorStateObject.self).filter("sensorID = '\(sensor.sensorID)'").first else { return }
        try! realm.write {
            query.enabled = !query.enabled
        }
    }       
    
    public func exists(sensor: SensorStateObject) -> Bool {
        let query = realm.objects(SensorStateObject.self).filter("sensorID = '\(sensor.sensorID)'").first
        if query != nil {
            return true
        } else {
            return false
        }
    }
    
    public func delete(sensorID: String) {
        let query = realm.objects(SensorStateObject.self).filter("sensorID = '\(sensorID)'").first
        guard let device = query else { return }
        try! realm.write {
            realm.delete(device)
        }
    }
    
    public func load(completion: @escaping (Result<[String: SensorState], Error>) -> Void) {
        let query = realm.objects(SensorStateObject.self)
        var temp = [SensorStateObject]()
        for sensor in query {
            temp.append(sensor)
        }
        if temp.isEmpty {
            completion(.failure(RealmDatabaseError.noRecordsInDatabase))
        } else {
            // convert SensorStateObject to SensorState
            var tempState = [String: SensorState]()
            for sensorObject in temp {
                var tempSensorState = SensorState.enabled
                if sensorObject.enabled {
                    tempSensorState = .enabled
                } else {
                    tempSensorState = .disabled
                }
                tempState[sensorObject.sensorID] = tempSensorState
            }
            completion(.success(tempState))
        }
    }
    
}
