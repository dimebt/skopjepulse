//
//  SensorsViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit
import Combine

protocol SensorsPresenterDelegate: class {
    func startLoading()
    func finishLoading()
    func sensorStateChanged()
    func showSensorDetails(city: City, sensor: Sensor, sensorData: SensorData)
    func errorFetching(error: Error)
    func didFinishQuering()
}

class SensorsPresenter: NSObject {
    
    weak var delegate: SensorsPresenterDelegate?
    public var city: City!
    public var sensors: Sensors!
    public var sensorData: SensorData!
    private var sensorsFetcher: NetworkFetcher<Sensors>!
    private var sensorDataFetcher: NetworkFetcher<SensorData>!
    private var endpointSensors: URL!
    private var endpointSensorData: URL!
    private var searchService: SensorSearchService!
    public var cellIdentifier = "sensorCell"
    public var sensorStates: [String: SensorState]!
    
    
    //  MARK: - Publisher (It publishes values over time, specificly this is the text from the UISearchBar)
    @Published public var searchText: String = ""
    
    //  MARK: - Subscriber
    public var searchTextSubscriber: AnyCancellable?
    
    init(city: City,
         sensorsFetcher: NetworkFetcher<Sensors> = NetworkFetcher<Sensors>(),
         sensorDataFetcher: NetworkFetcher<SensorData> = NetworkFetcher<SensorData>(),
         searchService: SensorSearchService = SensorSearchService()) {
        self.sensorsFetcher = sensorsFetcher
        self.sensorDataFetcher = sensorDataFetcher
        self.city = city
        self.endpointSensors = EndpointFactory.create(for: city, endpoint: .Sensors)
        self.endpointSensorData = EndpointFactory.create(for: city, endpoint: .Data24h)
        self.searchService = searchService
        self.sensorStates = [String: SensorState]()
    }
    
    //  MARK: - Fetching the sensor list
    public func fetchSensors() {
        delegate?.startLoading()
        loadStatesFromDB()
        sensorsFetcher.fetch(from: endpointSensors) { (result) in
            switch result {
            case .success(let sensors):                
                self.fetchSensorsData(sensors: sensors)
            case .failure(let error):
                self.delegate?.errorFetching(error: error)
            }
        }
    }
    
    //  MARK: - Fetching the sensors data
    private func fetchSensorsData(sensors: Sensors) {
        sensorDataFetcher.fetch(from: endpointSensorData) { (result) in
            switch result {
            case .success(let sensorData):
                self.sensors = sensors
                self.sensorData = sensorData
                self.subscribeToPublisher(sensors: sensors)
                self.delegate?.finishLoading()
            case .failure(let error):
                self.delegate?.errorFetching(error: error)
            }
        }
    }
    
    //  MARK: - Setting the subscriber on the publisher $searchText
    ///  Searching for the city in the [City] array with keyboard tapping debounce and removing duplicate entries
    private func subscribeToPublisher(sensors: Sensors) {
        searchTextSubscriber = $searchText
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { (term) in
                self.searchService.search(term: term, bag: sensors)
                self.sensors = self.searchService.queryResults
                self.delegate?.didFinishQuering()
            })
    }
    
    // MARK: - Load sensor states from database
    private func loadStatesFromDB() {
        SensorStatePersister.shared.load { (result) in
            switch result {
            case .success(let states):
                self.sensorStates = states
            case .failure(let error):
                print(error)
                // handle error
            }
        }
    }
    
    //  MARK: - Getter for the cell state
    public func getState(for sensor: Sensor) -> SensorState {
        guard let state = sensorStates[sensor.sensorId] else { return .enabled }
        return state
    }
    //  MARK: - Check if the user is allowed to tap on sensor cell
    //  If sensor is marked as disabled do not allow the user to go on sensor details screen
    public func canTap(on sensor: Sensor) {
        if getState(for: sensor).corespondingBoolState {
            delegate?.showSensorDetails(city: self.city, sensor: sensor, sensorData: self.sensorData)
        }
    }
    //  MARK: - Toggle clicking on the disable button on the SensorTableViewCell
    /// This state is alredy reverted, update the database and local cache
    public func toggle(sensor: Sensor, state: SensorState) {
        SensorStatePersister.shared.insert(sensor: SensorStateObject(value: [sensor.sensorId, state.corespondingBoolState]) )
        self.sensorStates[sensor.sensorId] = state
        delegate?.sensorStateChanged()
    }
}
