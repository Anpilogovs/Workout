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
        
        let sportgirlImageView = UIImageView(frame: CGRect(x: alertView.frame.width - alertView.frame.height * 0.4 / 2,
                                                           y: 30,
                                                           width: alertView.frame.height * 0.4,
                                                           height: alertView.frame.height * 0.4))
        
        sportgirlImageView.image = UIImage(named: "Girl")
        sportgirlImageView.contentMode = .scaleAspectFit
        alertView.addSubview(sportgirlImageView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        parentView.addSubview(alertView)
        
        let editingLabel = UILabel(frame: CGRect(x: 10,
                                                 y: alertView.frame.height * 0.4 + 50,
                                                 width: alertView.frame.width - 20,
                                                 height: 25))
        
        let setLabel =  UILabel(text: "Sets")
        setLabel.translatesAutoresizingMaskIntoConstraints = true
        setLabel.frame = CGRect(x: 30,
                                y: editingLabel.frame.maxY + 10,
                                width: alertView.frame.width - 60,
                                height: 20)
        alertView.addSubview(setLabel)
        
        editingLabel.text  = "Editing"
        editingLabel.textAlignment = .center
        editingLabel.font = .robotoMedium22()
        alertView.addSubview(editingLabel)
        
        let setsTextField = UITextField(frame: CGRect(x: 20,
                                                      y: setLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        setsTextField.backgroundColor = .specialLightBrown
        setsTextField.borderStyle = .none
        setsTextField.textColor = .specialGrey
        setsTextField.font = .robotoMedium20()
        setsTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 15,
                                                      height: setsTextField.frame.height))
        setsTextField.leftViewMode = .always
        setsTextField.clearButtonMode = .always
        setsTextField.returnKeyType = .done
        setsTextField.keyboardType = .numberPad
        alertView.addSubview(setsTextField)
        
        let repsLabel =  UILabel(text: "Reps")
        repsLabel.translatesAutoresizingMaskIntoConstraints = true
        repsLabel.frame = CGRect(x: 30,
                                 y: setsTextField.frame.maxY + 10,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(repsLabel)
        
        
        let repsTextField = UITextField(frame: CGRect(x: 20,
                                                      y: repsLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        repsTextField.backgroundColor = .specialLightBrown
        repsTextField.borderStyle = .none
        repsTextField.textColor = .specialGrey
        repsTextField.font = .robotoMedium20()
        repsTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 15,
                                                      height: setsTextField.frame.height))
        repsTextField.leftViewMode = .always
        repsTextField.clearButtonMode = .always
        repsTextField.returnKeyType = .done
        repsTextField.keyboardType = .numberPad
        alertView.addSubview(repsTextField)
        
        let okButton = UIButton(frame: CGRect(x: 50, y: repsTextField.frame.maxY + 15, width: alertView.frame.width - 100, height: 35))
        
        okButton.backgroundColor = .specialGrey
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font = .robotoMedium18()
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(okButton)
        
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
    
    @objc private func dismissAlert() {
        
        guard let targetView = mainView else { return }

        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.height,
                                          width: targetView.frame.width - 80,
                                          height: 420)
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundView.alpha = 0
                } completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                }

            }
        }

        
    }
}


