//
//  StartWorkoutViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 22.01.2023.
//

import Foundation
import UIKit

class StartWorkoutViewController: UIViewController {
    
    let startWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.textAlignment = .center
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Frame")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let startWorkoutView = StartWorkoutView()
    
    private let detailsLabel = UILabel(text: "Details")
    private var numberOfSet = 1
    
    var workoutModel = WorkoutModel()
    let customAler = CustomAlert()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        setWorkoutParameters()
        setDelegate()
        
        print(workoutModel)
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackgound
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(imageView)
        view.addSubview(detailsLabel)
        view.addSubview(startWorkoutView)
        view.addSubview(finishButton)
    }
    
    private func setDelegate() {
        startWorkoutView.cellNextSetDelegate = self
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateWorkoutModel(model: workoutModel, bool: true)
        } else {
            alertOkCancel(title: "Warning", message: "You have'n finifed your workout") {
                self.dismiss(animated: true)
            }
        }
    }

    private func setWorkoutParameters() {
        startWorkoutView.workoutNameLabel.text = workoutModel.workoutName
        startWorkoutView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        startWorkoutView.numberOfRepsLabel.text = "\(workoutModel.workoutReps)"
    }
}

extension StartWorkoutViewController: NextSetProtocol {
    func editingTap() {
        customAler.alertCustom(viewController: self) { _, _ in
            print("Aler")
        }
    }
    
    func nextSetTapped() {
        print("Tap")
        
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            startWorkoutView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }
}

extension StartWorkoutViewController {
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutView.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            startWorkoutView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            startWorkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startWorkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startWorkoutView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: startWorkoutView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
