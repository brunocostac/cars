//
//  CarType.swift
//  Cars
//
//  Created by Bruno Costa on 19/04/23.
//

import Foundation

enum CarType: Int {
    case classic = 0
    case luxury = 1
    case sports = 2
    case newCars = 3
    
    var id: Int {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .classic:
            return "Classic"
        case .luxury:
            return "Luxury"
        case .sports:
            return "Sports"
        case .newCars:
            return "New Cars"
        }
    }
}
