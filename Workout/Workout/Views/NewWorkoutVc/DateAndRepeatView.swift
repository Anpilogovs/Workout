//
//  newWorkout.swift
//  Workout
//
//  Created by Сергей Анпилогов on 16.01.2023.
//

import Foundation
import UIKit


class DateAndRepeatView: UIView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .robotoMedium18()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repeatEveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat every 7 days"
        label.font = .robotoMedium18()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let repeatSwitches: UISwitch = {
        let switches = UISwitch()
        switches.isOn = true
        switches.tintColor = .specialGreen
        switches.translatesAutoresizingMaskIntoConstraints = false
        return switches
    }()
    
    var dateStackView = UIStackView()
    var repeatStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .specialLightBrown
        
       dateStackView =  UIStackView(arrangedSubviews: [dateLabel,datePicker],
                                    axis: .horizontal, spacing: 10)
       repeatStackView = UIStackView(arrangedSubviews: [repeatEveryLabel,repeatSwitches],
                                      axis: .horizontal, spacing: 10)
        
        addSubview(dateStackView)
        addSubview(repeatStackView)
    }
}

extension DateAndRepeatView {
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
