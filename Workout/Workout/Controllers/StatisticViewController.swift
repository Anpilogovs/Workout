//
//  StatisticViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 17.01.2023.
//

import Foundation
import UIKit
import RealmSwift

struct DifferenceWorkout {
    let name: String
    let lastReps: Int
    let firstReps: Int
}

class StatisticViewController: UIViewController {

    let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTICS"
        label.font = .robotoMedium24()
        label.textColor = .specialBrown
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Week", "Month"])
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.selectedSegmentTintColor = .specialYellow
        segmentedControll.backgroundColor = .specialGreen
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont(name: "Roboto-Medium", size: 16)
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                  NSAttributedString.Key.foregroundColor: UIColor.white],
                                                 for: .normal)
       
        
        segmentedControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return segmentedControll
    }()
    
    let exercisesLabel = UILabel(text: "Exercises")
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = false
        return tableView
    }()

    private let idStatisticViewCell = "idStatisticViewCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>! = nil
//
    private var differenceArray = [DifferenceWorkout]()
    private var filtredDifference = [DifferenceWorkout]()

    let dateToday = Date().localDate()
    private var isFiltred = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        contraints()
        setDelegates()
        setStartScreen()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackgound
        
        view.addSubview(statisticsLabel)
        view.addSubview(segmentedControl)
        view.addSubview(exercisesLabel)
        view.addSubview(tableView)
        tableView.register(StatisticsTableViewCell.self,
                           forCellReuseIdentifier: idStatisticViewCell)
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setStartScreen() {
        getDifferenceModel(dateStart: dateToday.offSetDays(days: 7))
        tableView.reloadData()
    }
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offSetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
            tableView.reloadData()
        } else {
            differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offSetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
            tableView.reloadData()
        }
    }

    private func getWorkoutsName() -> [String] {

        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)

        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {

        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()

        for name in nameArray {

            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")

            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                return
            }
            let differenceWorkout = DifferenceWorkout(name: name,
                                                      lastReps: last,
                                                      firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
}

//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

//MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticViewCell, for: indexPath) as! StatisticsTableViewCell
        
        let differenceModel = differenceArray[indexPath.row]
        cell.cellConfigure(diffrenceWorkout: differenceModel)
        
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
            segmentedControl.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exercisesLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
