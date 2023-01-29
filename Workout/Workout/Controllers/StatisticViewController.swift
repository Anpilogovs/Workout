//
//  StatisticViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 17.01.2023.
//

import Foundation
import UIKit
import RealmSwift

class StatisticViewController: UIViewController {

    let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTICS"
        label.font = .robotoMedium24()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let segmendControl: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Неделя", "Месяц"])
        segmentedControll.selectedSegmentTintColor = .specialYellow
        segmentedControll.backgroundColor = .specialGreen
        segmentedControll.layer.cornerRadius = 10
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControll
    }()
    
    let exercises = UILabel(text: "Exercises")
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = false
        return tableView
    }()

    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>! = nil
    
    private let idStatisticViewCell = "idStatisticViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        contraints()
        delegates()
        
        
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: idStatisticViewCell)
    }
    
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackgound
        
        view.addSubview(statisticsLabel)
        view.addSubview(segmendControl)
        view.addSubview(exercises)
        view.addSubview(tableView)
    }
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticViewCell, for: indexPath) as! StatisticsTableViewCell
        
        return cell
    }
}

extension StatisticViewController {
    private func contraints() {
        
        NSLayoutConstraint.activate([
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            statisticsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            segmendControl.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 30),
            segmendControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmendControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exercises.topAnchor.constraint(equalTo: segmendControl.bottomAnchor, constant: 10),
            exercises.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: exercises.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
