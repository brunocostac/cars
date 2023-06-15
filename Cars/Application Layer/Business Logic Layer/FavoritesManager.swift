//
//  FavoritesManager.swift
//  Cars
//
//  Created by Bruno Costa on 07/06/23.
//

import Foundation
import CoreData
import UIKit


enum FavoriteManagerError: Equatable, Error {
    case CannotSave(String = "Não foi possível salvar o filme nos favoritos. Tente novamente.")
    case CannotFind(String = "O filme não foi encontrado.")
    case CannotRemove(String = "Não foi possível remover o filme. Tente novamente.")
    case CannotFetch(String = "Não foi possível obter a lista de filmes.")
}


class FavoriteManager {

    func save(car: Car, completion: @escaping (Favorite?, FavoriteManagerError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, FavoriteManagerError.CannotSave())
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let favorite = Favorite(context: managedContext)

        favorite.setValue(car.id, forKey: "id")
        favorite.setValue(car.name, forKey: "name")
        favorite.setValue(car.desc, forKey: "desc")
        favorite.setValue(car.price, forKey: "price")
        favorite.setValue(car.latitude, forKey: "latitude")
        favorite.setValue(car.longitude, forKey: "longitude")
        favorite.setValue(String(describing: car.url_image), forKey: "url_image")
        favorite.setValue(String(describing: car.url_info), forKey: "url_info")
        favorite.setValue(String(describing: car.url_video), forKey: "url_video")
        
        do {
            try managedContext.save()
            completion(favorite, nil)
        } catch {
            completion(nil, FavoriteManagerError.CannotSave())
        }
    }
    
    
    func fetch(car: Car, completion: @escaping (Car?,FavoriteManagerError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, FavoriteManagerError.CannotSave())
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == %d", car.id)
       
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            if fetchedResults.first != nil {
                completion(car, nil)
            } else {
                completion(nil, FavoriteManagerError.CannotFind())
            }
        } catch {
            completion(nil, FavoriteManagerError.CannotSave())
        }
    }
    
    func fetchAll(search: String = "", completion: @escaping ([Car]?, FavoriteManagerError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, FavoriteManagerError.CannotSave())
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")

        if !search.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", search)
        }

        do {
            let count = try managedContext.count(for: fetchRequest)

            let fetchedResults = try managedContext.fetch(fetchRequest)
            var cars = [Car]()
            
            for result in fetchedResults {
                cars.append(Car(id: Int(result.id), name: result.name ?? "", url_image: URL(string: result.url_image!)!, price: result.price ?? "", desc: result.desc!, url_info: URL(string: result.url_info!)!, url_video: URL(string: result.url_video!)!, latitude: result.latitude!, longitude: result.longitude!))
            }

            completion(cars, nil)
        } catch {
            completion(nil, FavoriteManagerError.CannotSave())
        }
    }
    
    
    func remove(car:Car, completion: @escaping (Car?, FavoriteManagerError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, FavoriteManagerError.CannotRemove())
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == %d", car.id)
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            if let result = fetchedResults.first {
                managedContext.delete(result)
                try managedContext.save()
                completion(car, nil)
            } else {
                completion(nil, FavoriteManagerError.CannotRemove())
            }
        } catch {
            completion(nil, FavoriteManagerError.CannotRemove())
        }
    }
}
