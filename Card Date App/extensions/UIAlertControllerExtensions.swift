//
//  Alert.swift
//  Card Date App
//
//  Created by Christoph on 3/25/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showSimpleAlert(_ parent: UIViewController, withTitle title: String, andDescription description: String) {
        
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        parent.present(alert, animated: true, completion: nil)
    }
}
