//
//  SimpleAlert.swift
//  Workout
//
//  Created by Сергей Анпилогов on 22.01.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}
