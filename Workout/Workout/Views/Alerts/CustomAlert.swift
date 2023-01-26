//
//  CustomAlert.swift
//  Workout
//
//  Created by Сергей Анпилогов on 26.01.2023.
//

import Foundation
import UIKit

class CustomAlert  {
    
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackgound
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    private var mainView: UIView?
    
    func alertCustom(viewController: UIViewController, completion: @escaping(String, String) -> Void) {
        
        guard let parentView = viewController.view else { return }
        mainView = parentView
        
        backgroundView.frame = parentView.frame
        parentView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        parentView.addSubview(alertView)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.8
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = parentView.center
                }
            }
        }
    }
}
