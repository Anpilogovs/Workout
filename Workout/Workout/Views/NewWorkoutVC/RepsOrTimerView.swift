//
//  WorkoutView.swift
//  Workout
//
//  Created by Сергей Анпилогов on 17.01.2023.
//

import Foundation
import UIKit

class RepsOrTimerView: UIView {
    
     let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.textColor = .specialBrown
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let setsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor =  .specialBrown
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseRepeatOrTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose repeat or timer"
        label.textColor =  .specialBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.textColor =  .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let repsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor =  .specialBrown
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = .robotoMedium20()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let timerNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "0 min"
        label.font = .robotoMedium20()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let setsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
         slider.addTarget(self, action: #selector(setsSliderChanged), for: .valueChanged)
        return slider
    }()
    
     let repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.tintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
         slider.addTarget(self, action: #selector(repsSliderChanged), for: .valueChanged)
        return slider
    }()
    
     let timerSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .specialGreen
        slider.maximumValue = 600
        slider.translatesAutoresizingMaskIntoConstraints = false
         slider.addTarget(self, action: #selector(timerSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    private var timerStackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc func setsSliderChanged() {
        setsNumberLabel.text = "\(Int(setsSlider.value))"
    }
    
    @objc func repsSliderChanged() {
        repsNumberLabel.text = "\(Int(repsSlider.value))"
        
        setNegative(label: timerLabel, numberLabel: timerNumberLabel, slider: timerSlider)
        setActive(label: repsLabel, numberLabel: repsNumberLabel, slider: repsSlider)
    }
    
    @objc func timerSliderChanged() {
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(timerSlider.value))
                    print(min,sec)
        
        timerNumberLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
        
        setNegative(label: repsLabel, numberLabel: repsNumberLabel, slider: repsSlider)
        setActive(label: timerLabel, numberLabel: timerNumberLabel, slider: timerSlider)
    }

    private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 1
        numberLabel.alpha = 1
        slider.alpha = 1
    }
    
    
   private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
       label.alpha = 0.5
       numberLabel.alpha = 0.5
       slider.alpha = 0.5
    }
  
    private func setupViews() {
    
        backgroundColor = .specialLightBrown
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, setsNumberLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(setsSlider)
        addSubview(chooseRepeatOrTimerLabel)
        addSubview(setsStackView)
        
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsNumberLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(repsSlider)
        addSubview(repsStackView)
        
        timerStackView = UIStackView(arrangedSubviews: [timerLabel, timerNumberLabel],
                                 axis: .horizontal,
                                     spacing: 10)
        addSubview(timerStackView)
        addSubview(timerSlider)
    }
}

extension RepsOrTimerView {
    
    private func setupContraint() {
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    
        NSLayoutConstraint.activate([
            setsSlider.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
        
        NSLayoutConstraint.activate([
            chooseRepeatOrTimerLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 20),
            chooseRepeatOrTimerLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: chooseRepeatOrTimerLabel.bottomAnchor, constant: 30),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            repsSlider.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
     
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            timerSlider.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
}
