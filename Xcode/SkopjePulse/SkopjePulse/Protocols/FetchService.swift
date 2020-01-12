//
//  FetchService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol FetchService {
    associatedtype T
    func fetch(from url: String, completion: @escaping (Result<T,Error>) -> Void)
}

class JsonFetcher: FetchService {
    
    func fetch(from url: String, completion: @escaping (Result<Int, Error>) -> Void) {
        
    }
}
