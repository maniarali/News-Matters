//
//  Toastable.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//
import UIKit

public protocol Toastable { }

public extension Toastable where Self: UIViewController {
    
    func showToast(message: String,
                   deadline: DispatchTimeInterval = .seconds(2),
                   completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .actionSheet)

        DispatchQueue.main.async { [unowned self] in
            self.present(alert, animated: true, completion: completion)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            alert.dismiss(animated: true)
        }
    }
}
