//
//  Extentions.swift
//  github_MostStared
//
//  Created by Abdullah on 13/04/2022.
//

import SDWebImage
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func fetchImageFromUrl(urlstring: String) {
        guard let url = URL(string: urlstring) else { return }
        if let image = imageCache.object(forKey: urlstring as NSString) as?
            UIImage
        {
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlstring as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
        
    func loadfromURL(_ url: String?) {
        sd_setImage(with: URL(string: url ?? ""), placeholderImage: UIImage(named: "Image-Placeholder"))
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
