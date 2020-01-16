//
//  NetworkFetcher.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

//  MARK: - FetchService Protocol that has fetching functionality for associated type
// I'm using for implementing different fetchers for different types of data in this case
// sensors form the REST API [Sensor] and sensors data for the last 24h [SensorData]
protocol FetchService {
    associatedtype T
    func fetch(from url: URL, completion: @escaping (Result<T,Error>) -> Void)
}

//  MARK: - Generic network fetcher
class NetworkFetcher<T: Decodable>: FetchService {
    
    func fetch(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
                completion(.failure(error))
            }
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.pulseStamp)
                let result = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async { () -> Void in
                    completion(.success(result))
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
}
