//
//  UIImageView+Extensions.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

extension UIImageView {
    /// Function to download image from url and also resposible to set on imageview if available
    /// - Parameters:
    ///   - url: URL to fetch image from
    ///   - mode: How image should be displayed
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    /// Function to download image from available string and also resposible to set on imageview if available
    /// - Parameters:
    ///   - link: string for image url
    ///   - mode: How image should be displayed
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let link, let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
