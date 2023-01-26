//
//  TimerStartView.swift
//  Workout
//
//  Created by Сергей Анпилогов on 24.01.2023.
//

import Foundation
import UIKit


class TimerStartView: UIView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Uknown"
        label.tintColor = .specialBrown
        label.textAlignment = .center
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.tintColor = .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let setsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0/0"
        label.tintColor = .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let timeOfSetLabel: UILabel = {
        let label = UILabel()
        label.text = "Uknown"
        label.tintColor = .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let timeOfSetNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0 min:00 sec"
        label.textAlignment = .right
        label.tintColor = .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let setsLineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialBrown
        return view
    }()
    
    let timerLineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialBrown
        return view
    }()
    
    let editingButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextSetButton: UIButton = {
       let button = UIButton()
        button.setTitle("NEXT SET", for: .normal)
        button.setTitleColor(UIColor.specialBrown, for: .normal)
        button.backgroundColor = .specialYellow
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
   private var setsStackView = UIStackView()
   private var timerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        layer.cornerRadius = 10
        backgroundColor = .specialLightBrown
        translatesAutoresizingMaskIntoConstraints = false
   
        setsStackView = UIStackView(arrangedSubviews: [setsLabel,setsNumberLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        timerStackView = UIStackView(arrangedSubviews: [timeOfSetLabel,timeOfSetNumberLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        addSubview(nameLabel)
        addSubview(setsStackView)
        addSubview(setsLineView)
        addSubview(timerStackView)
        addSubview(timerLineView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
}

extension TimerStartView {
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 5),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            timerLineView.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 5),
            timerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timerLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: timerLineView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            editingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
}

