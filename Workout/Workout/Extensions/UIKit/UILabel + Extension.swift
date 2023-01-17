//
//  UILabel + Extension.swift
//  Workout
//
//  Created by Сергей Анпилогов on 17.01.2023.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
