//
//  UIView+Extensions.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

extension UIView {
    func createCardView() {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.7
    }
}
