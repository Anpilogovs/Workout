//
//  ViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 15.01.2023.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textColor = .specialDarkGreen
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor  = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.tintColor = .specialDarkGreen
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.setImage(UIImage(named: "AddWorkout"), for: .normal)
        button.addTarget(self, action: #selector(addWorkoutButtonTrapped),
                         for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let workoutTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout today"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noTraining")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden =  true
        return imageView
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
        setUpContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeather()
        tableView.reloadData()
        setupUserParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        userArray = localRealm.objects(UserModel.self)
        setupViews()
        setUpContraints()
        setupDelegates()
        getWorkouts(date: Date())
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showOnBoarding()
    }
    
    private  func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackgound
        
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
    }
    
    @objc private func addWorkoutButtonTrapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true)
    }
    //если наш массив не пустой то добавляем данные на mainviewcontroller
    private func setupUserParameters() {
        if userArray.count != 0 {
            userNameLabel.text = userArray[0].userFirstName + userArray[0].userSecondName
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
        }
    }
    
    private func getWorkouts(date: Date) {
        
        let dateTimeZone = date
        let weekDay = dateTimeZone.getWeekDayNumber()
        let dateStart = dateTimeZone.startEndDate().0
        let dateEnd = dateTimeZone.startEndDate().1
        
        let predicatRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekDay) AND workoutRepeat = true")
        let predicatUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicatRepeat, predicatUnrepeat])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        tableView.reloadData()
        checkWorkoutsToday()
    }
    
    private func checkWorkoutsToday() {
        if workoutArray.count == 0 {
            tableView.isHidden = true
            noWorkoutImageView.isHidden = false
        } else {
            tableView.isHidden = false
            noWorkoutImageView.isHidden = true
            tableView.reloadData()
        }
    }
    
    private func showOnBoarding() {
        let userDefaults = UserDefaults.standard           
        let onBoardingWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed")
        if onBoardingWasViewed == false {
            let onboardingViewController = OnBoardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: false)
        }
    }
    
    private func getWeather() {
        NetworkDataFetch.shared.fetchWeather { [weak self] model, error in
            guard let self = self else { return }
            if error == nil {
                self.weatherView.descriptionWeatherLabel.text = model.weather[0].informationAboutWeather
                self.weatherView.nameWeatherLabel.text = "\(model.main.temperatureCelsius)°C"
                self.weatherView.weatherImageView.image = UIImage(systemName: model.weather[0].iconLocal)
            } else {
                self.alertOk(title: "Error", message: "Non Weather Data")
            }
        }
    }
}
//MARK: - StartWorkoutProtocol

extension MainViewController: StartWorkoutProtocol {
    
    func startButtonTapped(model: WorkoutModel) {
        
        if model.workoutTimer == 0 {
            let startWorkoutViewController = StartWorkoutViewController()
            startWorkoutViewController.modalPresentationStyle = .fullScreen
            startWorkoutViewController.workoutModel = model
            present(startWorkoutViewController, animated: true)
        } else {
           let timerStartViewController = TimerStartWorkoutViewController()
            timerStartViewController.timerWorkoutModel = model
            timerStartViewController.modalPresentationStyle = .fullScreen
            present(timerStartViewController, animated: true)
        }
    }
}
//MARK: - SelectCollectionViewItemProtocol

extension MainViewController: SelectCollectionViewItemProtocol {
    
    func selectItem(date: Date) {
        getWorkouts(date: date)
    }
}
//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as! WorkoutTableViewCell
        let model = workoutArray[indexPath.row]
        cell.cellConfigure(model: model)
        cell.cellStartWorkoutDelegate = self
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.reloadData()
        }
        action.backgroundColor = .specialBackgound
        action.image = UIImage(named: "Delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK: - setUpContraints
extension MainViewController {
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
        ])
    }
}
