//
//  NewWorkoutViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 16.01.2023.
//

import UIKit
import RealmSwift

class NewWorkoutViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delaysContentTouches = false   
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
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoMedium16()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    
    private let localRealm = try! Realm()
    private var workoutModel = WorkoutModel()
    
    private let testImage = UIImage(named: "")
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupDelegate()
        addTaps()

    }
    
    @objc func closeScrennButton() {
        dismiss(animated: true)
        print("closeScrennButton")
    }
    
  private func setupViews() {
      view.backgroundColor = .specialBackgound
      
      view.addSubview(scrollView)
      
      scrollView.addSubview(newWorkoutLabel)
      scrollView.addSubview(closeButton)
      scrollView.addSubview(nameLabel)
      scrollView.addSubview(nameTextField)
      scrollView.addSubview(dateAndRepeatlabel)
      scrollView.addSubview(dateAndRepeatView)
      scrollView.addSubview(repesOrTimerLabel)
      scrollView.addSubview(repsOrTimerView)
      scrollView.addSubview(saveButton)
    }
    
    private func setupDelegate() {
        nameTextField.delegate = self
    }
    
    private func addTaps() {
        let tapsScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapsScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapsScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyBoard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @objc private func swipeHideKeyBoard() {
        view.endEditing(true)
    }
    
    
    @objc func saveButtonTapped() {
        print("saveButtonTrapped")
        setModel()
        saveModel()
    }
    
    private func setModel() {
        guard let nameWorkout = nameTextField.text else { return }
        workoutModel.workoutName = nameWorkout
        
        workoutModel.workoutDate = dateAndRepeatView.datePicker.date.localDate()
        workoutModel.workoutNumberOfDay = dateAndRepeatView.datePicker.date.getWeekDayNumber()
        workoutModel.workoutRepeat = (dateAndRepeatView.repeatSwitches.isOn)
        
        workoutModel.workoutSets = Int(repsOrTimerView.setsSlider.value)
        workoutModel.workoutReps = Int(repsOrTimerView.repsSlider.value)
        workoutModel.workoutTimer = Int(repsOrTimerView.timerSlider.value)
        
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let count = text.filter { $0.isNumber || $0.isLetter }.count
        
        if count != 0 && workoutModel.workoutSets != 0 && workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0 {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            alertOk(title: "Success", message: nil)
            //            Mandatory updating the model after preservation
            workoutModel = WorkoutModel()
            refreshWorkoutObjects()
        } else {
            alertOk(title: "Error", message: "Choose all the parameters")
        }
    }
    
    private func refreshWorkoutObjects() {
        dateAndRepeatView.datePicker.setDate(Date(), animated: true)
        nameTextField.text = ""
        dateAndRepeatView.repeatSwitches.isOn = true
        repsOrTimerView.repsNumberLabel.text = "0"
        repsOrTimerView.repsNumberLabel.text = "0"
        repsOrTimerView.repsSlider.value = 0
        repsOrTimerView.setsLabel.text = "0"
        repsOrTimerView.setsNumberLabel.text = "0"
        repsOrTimerView.setsSlider.value = 0
    }
}

//MARK: - UITextFieldDelegate

extension NewWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}

extension NewWorkoutViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
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
            dateAndRepeatlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        NSLayoutConstraint.activate([
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatlabel.bottomAnchor, constant: 5),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            repesOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 5),
            repesOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repesOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            repsOrTimerView.topAnchor.constraint(equalTo: repesOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 320)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
}
