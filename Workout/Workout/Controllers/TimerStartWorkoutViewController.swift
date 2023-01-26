//
//  TimerStartViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 24.01.2023.
//

import Foundation
import UIKit


class TimerStartWorkoutViewController: UIViewController {
    
    let startWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeScreenButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let  timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipsee")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timerNumberLabel: UILabel = {
       let label = UILabel()
        label.text = "01:30"
        label.tintColor = .specialBrown
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel = UILabel(text: "Details")
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .specialDarkGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timerWorkoutView = TimerStartView()
    var timerWorkoutModel = WorkoutModel()
    
    private var numberOfSet = 1
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeScreenButton.layer.cornerRadius = closeScreenButton.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        setupContraints()
        setDelegate()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackgound
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeScreenButton)
        view.addSubview(timerImageView)
        timerImageView.addSubview(timerNumberLabel)
        view.addSubview(detailLabel)
        view.addSubview(timerWorkoutView)
        view.addSubview(finishButton)
        
        setupWorkoutParametersForScreenWithTimer()
        
    }

    private func setDelegate() {
        timerWorkoutView.nextSetDelegate = self
    }

    @objc func closeScreenButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupWorkoutParametersForScreenWithTimer() {
        timerWorkoutView.nameLabel.text = timerWorkoutModel.workoutName
        timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(timerWorkoutModel.workoutSets)"
        timerWorkoutView.timeOfSetNumberLabel.text = String(timerWorkoutModel.workoutTimer)
    }
}

extension TimerStartWorkoutViewController: nextSetForScreenWithTimerProtocol {
    func nextSetTapped() {
        
        print("Tap")
        
           if numberOfSet < timerWorkoutModel.workoutSets {
            numberOfSet += 1
               timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(timerWorkoutModel.workoutSets)"
        } else {
            alertOk(title: "Congratulations", message: "Finish your workout")
        }
    }
}

extension TimerStartWorkoutViewController {
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeScreenButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeScreenButton.heightAnchor.constraint(equalToConstant: 30),
            closeScreenButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            timerImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            timerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            timerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            timerNumberLabel.centerYAnchor.constraint(equalTo: timerImageView.centerYAnchor),
            timerNumberLabel.leadingAnchor.constraint(equalTo: timerImageView.leadingAnchor, constant: 70),
            timerNumberLabel.trailingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: -70),
        ])
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: timerImageView.bottomAnchor, constant: 30),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            timerWorkoutView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5),
            timerWorkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerWorkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerWorkoutView.heightAnchor.constraint(equalToConstant: 250)
        ])

        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
