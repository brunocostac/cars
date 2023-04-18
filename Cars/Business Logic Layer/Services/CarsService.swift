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
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getCars() throws -> [Car] {
        let url = URL(string: "https://gist.githubusercontent.com/brunocostac/c3a37b482eb408b50661d41805ca9aac/raw/25b601db5ae94aff7c7fd65d9724398e7f8c9363/json")!
        
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
    
    func getCar(with id: String) throws -> Car? {
        let cars = try getCars()
        return cars.first(where: { $0.id == id })
    }
}
