//
//  StartWorkoutView.swift
//  Workout
//
//  Created by Сергей Анпилогов on 22.01.2023.
//

import Foundation
import UIKit

class StartWorkoutView: UIView {
    
    let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bicieps"
        label.font = .robotoMedium24()
        label.textColor = .specialGrey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let numberOfSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "1/4"
        label.textColor = .specialGrey
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.font = .robotoMedium20()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let numberOfRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.font = .robotoMedium24()
        label.textColor = .specialGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT SET", for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.backgroundColor = .specialYellow
        button.titleLabel?.textAlignment = .center
        button.tintColor = .specialDarkGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let editingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editing", for: .normal)
        button.setImage(UIImage(named: "Editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.tintColor = .specialLightBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var setsStackView = UIStackView()
    var repsStackView = UIStackView()
    
    weak var cellNextSetDelegate: NextSetProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 10
     
        setsStackView = UIStackView.init(arrangedSubviews: [setsLabel,numberOfSetsLabel],
                                         axis: .horizontal,
                                         spacing: 10)
        repsStackView = UIStackView.init(arrangedSubviews: [repsLabel,numberOfRepsLabel],
                                         axis: .horizontal,
                                         spacing: 10)
       
        addSubview(workoutNameLabel)
        addSubview(setsStackView)
        addSubview(repsStackView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
    
    @objc func editingButtonTapped() {
      
    }
    
    @objc func nextSetsButtonTapped() {
        cellNextSetDelegate?.nextSetTapped()
    }
}

extension StartWorkoutView {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 25),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 25),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 20),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 80),
            editingButton.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 20),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
