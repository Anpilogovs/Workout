//
//  NewWorkoutViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 16.01.2023.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let newWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW WORKOUT"
        label.font = .robotoMedium24()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameLabel = UILabel(text: "Name")
    private let dateAndRepeatlabel = UILabel(text: "Date and repeat")
    private let repesOrTimerLabel = UILabel(text: "Reps or timer")
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialLightBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGrey
        textField.font = .robotoMedium20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeScrennButton),
                         for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeScrennButton),
                         for: .touchUpInside)
        return button
    }()
    
    private let newWorkoutView = DateAndRepeatView()
    private let workouView = RepsOrTimerView()
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupDelegate()
        addTaps()
        nameTextField.becomeFirstResponder()

        view.backgroundColor = .specialBackgound
    }
    
    @objc func closeScrennButton() {
        dismiss(animated: true)
        print("closeScrennButton")
    }
    
  private func setupViews() {
      view.addSubview(newWorkoutLabel)
      view.addSubview(closeButton)
      view.addSubview(nameLabel)
      view.addSubview(nameTextField)
      view.addSubview(dateAndRepeatlabel)
        
      view.addSubview(newWorkoutView)
      view.addSubview(repesOrTimerLabel)
      view.addSubview(workouView)
      view.addSubview(saveButton)
    }
    
    private func setupDelegate() {
        nameTextField.delegate = self
    }
    
    private func addTaps() {
        let tapsScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapsScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapsScreen)
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
}

extension NewWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}

extension NewWorkoutViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
            
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatlabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])

        NSLayoutConstraint.activate([
            newWorkoutView.topAnchor.constraint(equalTo: dateAndRepeatlabel.bottomAnchor, constant: 5),
            newWorkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newWorkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newWorkoutView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            repesOrTimerLabel.topAnchor.constraint(equalTo: newWorkoutView.bottomAnchor, constant: 20),
            repesOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repesOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            workouView.topAnchor.constraint(equalTo: repesOrTimerLabel.bottomAnchor, constant: 3),
            workouView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workouView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workouView.heightAnchor.constraint(equalToConstant: 320)
            
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: workouView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
        
    }
}
