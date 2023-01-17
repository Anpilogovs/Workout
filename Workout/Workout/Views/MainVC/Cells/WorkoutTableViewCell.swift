//
//  WorkoutTableViewCell.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackgound
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        imageView.contentMode  = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.textColor = .specialGrey
        label.backgroundColor = .red
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.textColor = .specialGrey
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 2"
        label.textColor = .specialGrey
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor  = .specialYellow
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.tintColor = .specialDarkGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTrapped), for: .touchUpInside)
        return button
    }()
    
    var labelsStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        
        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        addSubview(workoutImageView)
        addSubview(workoutNameLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                      axis: .horizontal,
                                      spacing: 10)
      
        addSubview(labelsStackView)
//        It is advisable to add button to ContentView
        contentView.addSubview(completeButton)
    }
    
    @objc func startButtonTrapped() {
        print("startButtonTrapped")
    }
    
   private func setupContraints() {
       
       NSLayoutConstraint.activate([
              backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
              backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
              backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
              backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
       ])
       
       NSLayoutConstraint.activate([
        workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
        workoutBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
        workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70)
       ])

       NSLayoutConstraint.activate([
        workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
        workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
        workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
        workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10)
       ])

       NSLayoutConstraint.activate([
       workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
       workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
       workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
       ])

       NSLayoutConstraint.activate([
           labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
           labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
           labelsStackView.heightAnchor.constraint(equalToConstant: 20)
       ])
       
        NSLayoutConstraint.activate([
            completeButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 5),
            completeButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            completeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
