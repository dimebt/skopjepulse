//
//  LocalJsonFetcher.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class LocalJsonFetcher<T: Decodable>: FetchService {
    
    func fetch(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let path = Bundle.main.path(forResource: url.absoluteString, ofType: "json")
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(result))
        } catch let error {
            completion(.failure(error))
        }
    }
}