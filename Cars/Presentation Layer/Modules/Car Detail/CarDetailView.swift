//
//  CarDetailView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit
import MapKit

class CarDetailView: UIView {
    
    // MARK: - Properties
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.translatesAutoresizingMaskIntoConstraints = false
       scrollView.showsVerticalScrollIndicator = true
       scrollView.isScrollEnabled = true // Enable scrolling
       return scrollView
    }()
    
    lazy var contentView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    lazy var imageView: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       image.contentMode = .scaleAspectFit
       return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = true
        mapView.layer.cornerRadius = 8.0
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.systemGray4.cgColor
        mapView.layer.masksToBounds = false
        mapView.clipsToBounds = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    public func updateLabels(with title: String, desc: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.descLabel.text = desc
        }
    }
    
    public func updateImage(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
    func updateMapRegionAndAnnotation(car: Car) {
        let zoomLevel = 0.005
        let latitude = Double(car.latitude)!
        let longitude = Double(car.longitude)!
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(location, animated: true)
        
        
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = car.name
        mapView.addAnnotation(pin)
    }
}

// MARK: - UI Setup
extension CarDetailView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.backgroundColor = .white
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(descLabel)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(mapView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
    
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                        
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            locationTitleLabel.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 16),
            locationTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            mapView.topAnchor.constraint(equalTo: self.locationTitleLabel.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            mapView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
}

