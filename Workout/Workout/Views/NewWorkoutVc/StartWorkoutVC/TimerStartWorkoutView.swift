//
//  TimerStartView.swift
//  Workout
//
//  Created by Сергей Анпилогов on 24.01.2023.
//

import Foundation
import UIKit
import RealmSwift

protocol nextSetForScreenWithTimerProtocol: AnyObject {
    func nextSetButtonForTimerViewControllerTapped()
    func editingButtonForTimeViewControllerTap()
}

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
        label.font = .robotoMedium18()
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
        label.text = "Timer of Set"
        label.tintColor = .specialBrown
        label.font = .robotoMedium18()
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
        button.addTarget(self, action: #selector(editingTimerButtonTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>! = nil
    
    private var setsStackView = UIStackView()
    private var timerStackView = UIStackView()
    
    
    weak var nextSetDelegate: nextSetForScreenWithTimerProtocol?
    
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
        setsStackView.distribution = .equalSpacing

        timerStackView = UIStackView(arrangedSubviews: [timeOfSetLabel,timeOfSetNumberLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        timerStackView.distribution = .equalSpacing
        addSubview(nameLabel)
        addSubview(setsStackView)
        addSubview(setsLineView)
        addSubview(timerStackView)
        addSubview(timerLineView)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }
    
    @objc func nextSetButtonTapped() {
        nextSetDelegate?.nextSetButtonForTimerViewControllerTapped()
    }
    
    @objc func editingTimerButtonTapped() {
        nextSetDelegate?.editingButtonForTimeViewControllerTap()
    }
}

extension TimerStartView {
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 5),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 5),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            timerLineView.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 5),
            timerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timerLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: timerLineView.bottomAnchor, constant: 20),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.widthAnchor.constraint(equalToConstant: 80),
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

