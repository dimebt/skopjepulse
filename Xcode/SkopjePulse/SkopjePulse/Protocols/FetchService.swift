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
    func fetch(from url: URL, completion: @escaping (Result<T,Error>) -> Void)
}
