//
//  CarsService.swift
//  Cars
//
//  Created by Bruno Costa on 17/04/23.
//

import Foundation

protocol CarsService: AnyObject {
    func getCars() throws -> [Car]
    func getCar(with id: String) throws -> Car?
}


class CarsServiceImplementation: CarsService {

    func getCars() throws -> [Car] {
        return [Car(id: "1", name: "Honda")]
    }
    
    func getCar(with id: String) throws -> Car? {
        return Car(id: "2", name: "Chevrolet")
    }
}

