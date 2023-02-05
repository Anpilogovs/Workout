//
//  WeatherView.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import UIKit

class WeatherView: UIView {
    
     let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнышко"
        label.textColor = .specialGrey
        label.font = .robotoMedium18()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGrey
        label.text = "Хорошоая погода,чтобы позаниматься на улице"
        label.numberOfLines = 2
        label.layer.opacity = 0.3
        label.font = .robotoMedium16()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 10
            addShadowOnView()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherImageView)
        addSubview(nameWeatherLabel)
        addSubview(descriptionWeatherLabel)
    }
}

extension WeatherView {
    func setupContraint() {
        NSLayoutConstraint.activate([
            
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameWeatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameWeatherLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            nameWeatherLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
        
        descriptionWeatherLabel.topAnchor.constraint(equalTo: nameWeatherLabel.bottomAnchor, constant: 5),
        descriptionWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        descriptionWeatherLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
        descriptionWeatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        
        ])
    }
}
