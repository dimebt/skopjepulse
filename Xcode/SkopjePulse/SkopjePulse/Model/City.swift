//
//  City.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol NameRepresentable {
    var name: String { get }
}

protocol Lowercased { }

extension Lowercased where Self: NameRepresentable {
    var lowercased: String {
        return self.name.lowercased()
    }
}

struct City: Hashable, NameRepresentable {
    var name: String
}


