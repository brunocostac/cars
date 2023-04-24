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
    let id: Int
    let name: String
    let url_image: URL
    let desc: String
    let url_info: URL
    let url_video: URL
    let latitude: String
    let longitude: String
    
    init(id: Int, name: String, url_image: URL, desc: String, url_info: URL, url_video: URL, latitude: String, longitude: String) {
        self.id = id
        self.name = name
        self.url_image = url_image
        self.desc = desc
        self.url_info = url_info
        self.url_video = url_video
        self.latitude = latitude
        self.longitude = longitude
    }
}
