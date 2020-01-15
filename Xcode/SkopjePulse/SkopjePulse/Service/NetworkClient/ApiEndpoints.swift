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

struct PulseEco {
    static let skopje = City(name: "Skopje")
    static let bitola = City(name: "Bitola")
    static let brasov = City(name: "Brasov")
    static let copenhagen = City(name: "Copenhagen")
    static let ohrid = City(name: "Ohrid")
    static let clujNapoca = City(name: "Cluj-Napoca")
    static let codlea = City(name: "Codlea")
    static let gostivar = City(name: "Gostivar")
    static let grandRapids = City(name: "Grand Rapids")
    static let kichevo = City(name: "Kichevo")
    static let kumanovo = City(name: "Kumanovo")
    static let nis = City(name: "Nis")
    static let novoselo = City(name: "Novo Selo")
    static let portland = City(name: "Portland")
    static let shtip = City(name: "Shtip")
    static let sofia = City(name: "Sofia")
    static let strumica = City(name: "Strumica")
    static let targumures = City(name: "Targu Mures")
    static let tetovo = City(name: "Tetovo")
    static let yambol = City(name: "Yambol")
    static let zagreb = City(name: "Zagreb")
    
    public static let cities = [
        skopje,
        bitola,
        brasov,
        copenhagen,
        ohrid,
        clujNapoca,
        codlea,
        gostivar,
        grandRapids,
        kichevo,
        kumanovo,
        nis,
        novoselo,
        portland,
        shtip,
        sofia,
        strumica,
        targumures,
        tetovo,
        yambol,
        zagreb
    ]
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
    public static func create(for city: City, endpoint: Endpoint) -> URL? {
        switch endpoint {
        case .Sensors:
            guard let url = URL(string: "https://\(city.name.lowercased().replacingOccurrences(of: " ", with: "-")).pulse.eco/rest/sensor") else { return nil}
            return url
        case .Data24h:
            guard let url = URL(string: "https://\(city.name.lowercased()).pulse.eco/rest/data24h") else { return nil}
            return url
        }
    }
}
