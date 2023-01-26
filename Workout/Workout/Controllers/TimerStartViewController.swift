//
//  TimerStartViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 24.01.2023.
//

import Foundation
import UIKit


class TimerStartViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.tintColor = .white
        button.backgroundColor = .specialDarkGreen
        button.setTitle("FINISH", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let timerWorkoutView = TimerStartView()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        setupContraints()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackgound
        
        view.addSubview(nameLabel)
        view.addSubview(closeButton)
        view.addSubview(timerImageView)
        timerImageView.addSubview(timerNumberLabel)
        view.addSubview(timerWorkoutView)
        view.addSubview(detailLabel)
        view.addSubview(finishButton)
    }
}

extension TimerStartViewController {
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            timerImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            timerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            timerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
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
            timerWorkoutView.heightAnchor.constraint(equalToConstant: 230)
        ])

        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutView.bottomAnchor, constant: 10),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
