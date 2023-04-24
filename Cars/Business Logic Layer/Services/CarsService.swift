//
//  CarsService.swift
//  Cars
//
//  Created by Bruno Costa on 17/04/23.
//

import Foundation

protocol CarsService: AnyObject {
    func getCars(with carType: CarType) throws -> [Car]
    func getCar(with id: Int, carType: CarType) throws -> Car?
    func getURL(with carType: CarType) -> URL
}


class CarsServiceImplementation: CarsService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getURL(with carType: CarType) -> URL {
        switch carType {
        case CarType.classic:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/878b8c7ed33df6cedcc0f87863fc6af7/raw/7859fece0a4c31e4532d6b897ad504accc941a33/json")!
        case CarType.sports:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/963b285b3cb831756cf4a1b31ea46659/raw/7725dbf64e346c3a7c348b5136299eaa6684c0a1/json")!
        case CarType.luxury:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/4308cc3d9e6d6818ec0106f3f23824d7/raw/cea85dd91283f31b4853bb12bd2ede89eb1c0d7d/json")!
        default:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/878b8c7ed33df6cedcc0f87863fc6af7/raw/7859fece0a4c31e4532d6b897ad504accc941a33/json")!
        }
    }
    
    func getCars(with carType: CarType) throws -> [Car] {
        let url = self.getURL(with: carType)
        let semaphore = DispatchSemaphore(value: 0)
        var cars: [Car] = []
        
        let task = session.dataTask(with: url) { data, response, error in
            defer { semaphore.signal() }
            
            if let error = error {
                print("Error fetching cars: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from server")
                return
            }
            
            do {
                cars = try JSONDecoder().decode([Car].self, from: data)
            } catch {
                print("Error decoding cars JSON: \(error)")
            }
        }
        
        task.resume()
        semaphore.wait()
        
        return cars
    }
    
    func getCar(with id: Int, carType: CarType) throws -> Car? {
        let cars = try getCars(with: carType)
        return cars.first(where: { $0.id == id })
    }
}
