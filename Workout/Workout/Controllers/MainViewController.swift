//
//  ViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private let calendarView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .specialGreen
//        view.layer.cornerRadius = 10
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textColor = .specialGrey
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor  = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.tintColor = .specialDarkGreen
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.setImage(UIImage(named: "AddWorkout"), for: .normal)
        button.addTarget(self, action: #selector(addWorkoutButtonTrapped),
                         for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let calendarView = CalendarView()

    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpContraints()
    }
    
    
    private func setupViews() {
        view.backgroundColor = .specialBackgound
        
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
    }
    
    @objc private func addWorkoutButtonTrapped() {
        print("addWorkoutButtonTrapped")
    }
}

extension MainViewController {
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
        ])
    }
}
