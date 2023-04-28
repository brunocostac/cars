//
//  CarListInteractor.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import Foundation


protocol CarListInteractor: AnyObject {
    func viewDidAppear()
    func didSelectRow(at index: Int)
    func didSelectCarType(at carType: Int)
}

class CarListInteractorImplementation: CarListInteractor {
    var presenter: CarListPresenter?
    
    private let carsService = CarsServiceImplementation()
    private var cars: [Car] = []
    private var selectedCarType: CarType?
    
    func viewDidAppear()  {
        self.getCars()
        self.getCarTypeList()
    }
    
    func getCarTypeList()  {
        var carTypes: [[String: Any]] = []

        let classicCarType = ["id": CarType.classic.id, "name": CarType.classic.name, "image_url": "https://img.hmn.com/900x0/stories/2018/08/301531.jpg"] as [String : Any]
        carTypes.append(classicCarType)

        let luxuryCarType = ["id": CarType.luxury.id, "name": CarType.luxury.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/luxo/Bugatti_Veyron.png"] as [String : Any]
        carTypes.append(luxuryCarType)

        let sportsCarType = ["id": CarType.sports.id, "name": CarType.sports.name, "image_url": "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Audi_Spyder.png"] as [String : Any]
        carTypes.append(sportsCarType)
        
        self.presenter?.interactor(didRetrieveCarType: carTypes)
    }
    
    func getCars() {
        do {
            self.selectedCarType = CarType.classic
            self.carsService.getCars(with: selectedCarType!) { result in
                switch result {
                case .success(let cars):
                    self.cars = cars
                    self.presenter?.interactor(didRetrieveCars: self.cars)
                    self.presenter?.interactor(didRetrieveCarTypeName: self.selectedCarType!.name)
                case .failure(let error):
                    self.presenter?.interactor(didFailRetrieveCars: error)
                }
            }
        } catch {
            self.presenter?.interactor(didFailRetrieveCars: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.cars.indices.contains(index) {
            self.presenter?.interactor(didFindCar: self.cars[index], carType: selectedCarType!)
        }
    }
    
    func didSelectCarType(at carType: Int) {
        self.selectedCarType = CarType(rawValue: carType)
        do {
            self.carsService.getCars(with: selectedCarType!) { result in
                switch result {
                case .success(let cars):
                    self.cars = cars
                    self.presenter?.interactor(didRetrieveCarTypeName: self.selectedCarType!.name)
                    self.presenter?.interactor(didRetrieveCars: self.cars)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            self.presenter?.interactor(didFailRetrieveCars: error)
        }
    }
}
