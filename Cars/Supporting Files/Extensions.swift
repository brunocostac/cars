//
//  Extensions.swift
//  Cars
//
//  Created by Bruno Costa on 17/04/23.
//

import UIKit

extension UIViewController {
    func showError(with message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UICollectionView {
    
    @objc func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.backgroundColor = .clear
        messageImageView.image = messageImage
        messageImageView.tintColor = .systemGray
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.text = title
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 17)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        
        NSLayoutConstraint.activate([
            messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
            messageImageView.widthAnchor.constraint(equalToConstant: 150),
            messageImageView.heightAnchor.constraint(equalToConstant: 150)
        
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
       
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
        
    
        UIView.animate(withDuration: 1, animations: {
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        self.backgroundView = emptyView
    }
}

extension UINavigationBar {
    
    static func setGlobalAppearance() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .purple
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = UIColor.purple
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = true
        }
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "back_arrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "back_arrow")
        
    }
}


extension String {
    func formatToDollar() -> String? {
        let cleanedNumberString = self.replacingOccurrences(of: ".", with: "")
        
        guard let number = Double(cleanedNumberString) else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"  // Set the currency code if needed
        formatter.locale = Locale.current  // Use the current locale
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        }
        
        return nil
    }
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
