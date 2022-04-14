//
//  Extentions.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import UIKit
import SDWebImage




extension UIImageView {
    func fetchImageFromUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    
    
    func loadfromURL(_ url : String?) {
            sd_setImage(with: URL(string: url ?? "") , placeholderImage: UIImage(named: "Image-Placeholder"))
        }
}




private var containerView: UIView!

extension UIViewController {
    
    func showLoadingView() {
            containerView = UIView(frame: view.bounds)
            view.addSubview(containerView)
            
            containerView.backgroundColor = .systemBackground
            containerView.alpha = 0
            
            UIView.animate(withDuration: 0.25) { containerView.alpha = 0.75 }
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            containerView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            activityIndicator.startAnimating()
        }
        
        func dismissLoadingView() {
            DispatchQueue.main.async {
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    
    
}
