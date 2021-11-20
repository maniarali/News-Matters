//
//  UIView+Extensions.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

extension UIView {
    
    /// Will convert AnyView in card shape
    func createCardView(cornerRadius: CGFloat = 20.0,
                        shadowColor: CGColor = UIColor.darkGray.cgColor,
                        shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                        shadowRadius: CGFloat = 8.0,
                        shadowOpacity: Float = 0.7) {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
