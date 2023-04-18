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

class Car: Decodable {
    let id: String
    let name: String
    let image_url: URL
    
    init(id: String, name: String, image_url: URL) {
        self.id = id
        self.name = name
        self.image_url = image_url
    }
}
