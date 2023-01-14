//
//  UIView + Extension.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import Foundation
import UIKit

extension UIView {
    
    
    func addShadowOnView() {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
    
    
}
