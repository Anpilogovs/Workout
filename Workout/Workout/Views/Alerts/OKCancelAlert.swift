//
//  OKCancelAlert.swift
//  Workout
//
//  Created by Сергей Анпилогов on 23.01.2023.
//

import UIKit

extension UIViewController {
    
    func alertOkCancel(title: String, message: String?, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}
