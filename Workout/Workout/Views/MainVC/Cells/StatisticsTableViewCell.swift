//
//  StatisticsTableViewCell.swift
//  Workout
//
//  Created by Сергей Анпилогов on 29.01.2023.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
   private let labelNameWorkout: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  private  let beforeLabel = UILabel(text: "Before:")
    let nowLabel = UILabel(text: "Now:")
    
   private let numeberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoMedium20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
   private var beforeAndNowStackView = UIStackView()

  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
        beforeAndNowStackView  = UIStackView(arrangedSubviews: [beforeLabel,nowLabel],
                                             axis: .horizontal,
                                             spacing: 10)
        addSubview(labelNameWorkout)
        addSubview(beforeAndNowStackView)
        addSubview(numeberLabel)
        addSubview(lineView)
    }
}

extension StatisticsTableViewCell {
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            labelNameWorkout.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            labelNameWorkout.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            beforeAndNowStackView.topAnchor.constraint(equalTo: labelNameWorkout.bottomAnchor, constant: 10),
            beforeAndNowStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            numeberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            numeberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: beforeAndNowStackView.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
