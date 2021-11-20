//
//  Routable.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

protocol Routable: class {
    static func instantiate<T: UIViewController>() -> T
}

extension Routable {
    static func instantiate<T: UIViewController>() -> T {
        let storyboard: UIStoryboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return viewController
    }
}
