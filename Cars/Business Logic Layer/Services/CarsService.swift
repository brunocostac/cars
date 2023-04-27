//
//  CarsService.swift
//  Cars
//
//  Created by Bruno Costa on 17/04/23.
//

import Foundation

protocol CarsService: AnyObject {
    func getCars(with carType: CarType, completion: @escaping (Result<[Car], Error>) -> Void)
    func getCar(with id: Int, carType: CarType, completion: @escaping (Result<Car?, Error>) -> Void)
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
            return URL(string: "https://gist.githubusercontent.com/brunocostac/878b8c7ed33df6cedcc0f87863fc6af7/raw/75d04a29f930e3ade20756b673d5a355f036f44e/json")!
        case CarType.sports:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/963b285b3cb831756cf4a1b31ea46659/raw/2c2609e8ed88912c8ad5c2ee099a7453c9ad52fe/json")!
        case CarType.luxury:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/4308cc3d9e6d6818ec0106f3f23824d7/raw/0c216b6107845f55d1ade70846e1d9dd8056994e/json")!
        default:
            return URL(string: "https://gist.githubusercontent.com/brunocostac/878b8c7ed33df6cedcc0f87863fc6af7/raw/75d04a29f930e3ade20756b673d5a355f036f44e/json")!
        }
    }
    
    func getCars(with carType: CarType, completion: @escaping (Result<[Car], Error>) -> Void) {
        let url = self.getURL(with: carType)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "YourApp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned from server"])))
                return
            }
            
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                completion(.success(cars))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getCar(with id: Int, carType: CarType, completion: @escaping (Result<Car?, Error>) -> Void) {
        self.getCars(with: carType) { result in
            switch result {
            case .success(let cars):
                let car = cars.first(where: { $0.id == id })
                completion(.success(car))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
