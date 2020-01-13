//
//  Endpoints.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

//  MARK: - API Endpoints for pulse.eco Cities
/// Endpoints are hardcoded becouse there is no service for fetching the list of the cities that pulse.eco supports


/*  MARK: - REST Endpoints
     - get sensors for city
    https://[CITY].pulse.eco/rest/sensor

    - get sensor data for city
    https://[CITY].pulse.eco/rest/data24h
*/

enum PulseCity: String {
    case Skopje
    case Bitola
    case Tetovo
    case Ohrid
}

enum Endpoint {
    case Sensors
    case Data24h
}


/// Helper struct that generates the rest endpoints for the app
struct EndpointFactory {
    /// Static function that concatanates the rest endpoints for passed city and returns the complete URL REST Path
    /// - Parameters:
    ///   - city: City that Pulse.eco supports
    ///   - endpoint: Endpoint for the Sensors or for the sensors data for the last 24h
    public static func create(for city: PulseCity, endpoint: Endpoint) -> URL? {
        switch endpoint {
        case .Sensors:
            guard let url = URL(string: "https://\(city.rawValue.lowercased()).pulse.eco/rest/sensor") else { return nil}
            return url
        case .Data24h:
            guard let url = URL(string: "https://\(city.rawValue.lowercased()).pulse.eco/rest/data24h") else { return nil}
            return url
        }
    }
}
