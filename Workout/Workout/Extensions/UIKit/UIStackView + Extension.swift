//
//  UIStackView + Extension.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import Foundation
import UIKit



//let stackView = UIStackView()
//stackView.addAranngedSubview()
//stackView.addAranngedSubview()
//stackView.axis = .horizontal
//stackView.spacing = 10
//stackView.translatesAutoresizingMaskIntoConstraints = false


extension UIStackView {
    
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis,spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
