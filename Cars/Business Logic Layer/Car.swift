//
//  Car.swift
//  Cars
//
//  Created by Bruno Costa on 17/04/23.
//

import Foundation

class CarList {
    let cars: [Car] = []
}

class Car {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
