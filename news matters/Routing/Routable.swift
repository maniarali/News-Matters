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
    
    /// Seprate Storyboard should be created for every UIViewController and it will automatically cast into that viewcontroller
    /// - Returns: Intialize ViewController with storyboard
    static func instantiate<T: UIViewController>() -> T {
        let storyboard: UIStoryboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return viewController
    }
}
