//
//  CarDetailView.swift
//  Cars
//
//  Created by Bruno Costa on 14/04/23.
//

import UIKit

class CarDetailView: UIView {
    
    // MARK: - Properties
    
    lazy var imageView: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       image.contentMode = .scaleAspectFit
       return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    public func updateLabel(with text: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = text
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
}

// MARK: - UI Setup
extension CarDetailView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.backgroundColor = .white
        
        //self.addSubview(titleLabel)
        self.addSubview(imageView)
        
        
        NSLayoutConstraint.activate([
            //titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
           // titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        
        ])
    }
}

