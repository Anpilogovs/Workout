import Foundation
import UIKit
import RealmSwift

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}


final class ProfilViewController: UIViewController {
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialGrey
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR NAME"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let userPhotoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialDarkGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let height = UILabel(text: "Height: _")
    let Weight = UILabel(text: "Weight: _")
    
    private  let profileEditingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editing ", for: .normal)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let userHeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: _"
        label.textColor = .specialGrey
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight: _"
        label.textColor = .specialGrey
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.font  = .robotoMedium18()
        button.semanticContentAttribute = .forceLeftToRight
        button.setImage(UIImage(systemName: "ellipse.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.text  = "TARGET: 0 workouts"
        label.font = .robotoMedium16()
        label.textColor = .specialGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutsNowLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoMedium16()
        label.textColor = .specialGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutTargetLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .specialBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 14
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: false)
        progressView.layer.sublayers?[1].cornerRadius = 14
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private var targetStackView = UIStackView()
    private var userParamStackView = UIStackView()
    private let idProfileCollectionViewCell = "idProfileCollectionViewCell"
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    private var resultWorkout = [ResultWorkout]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUserParameters()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        editingButton.layer.cornerRadius = editingButton.frame.width / 2
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArray = localRealm.objects(UserModel.self)
        
        setupView()
        setupConstraints()
        setupDelegate()
        getWorkoutResults()
    }
    
    private func setupView() {
        
        view.backgroundColor = .specialBackgound
        view.addSubview(profileLabel)
        view.addSubview(userPhotoView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        
        userParamStackView = UIStackView(arrangedSubviews: [userHeightLabel, userWeightLabel], axis: .horizontal, spacing: 10)
        view.addSubview(userParamStackView)
        view.addSubview(editingButton)
        view.addSubview(collectionView)
        
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCollectionViewCell)
        view.addSubview(targetLabel)
        
        targetStackView = UIStackView(arrangedSubviews: [workoutsNowLabel, workoutTargetLabel], axis: .horizontal, spacing: 10)
        
        view.addSubview(targetStackView)
        view.addSubview(targetView)
        view.addSubview(progressView)
    }
    
   private func setupDelegate() {
       collectionView.delegate = self
       collectionView.dataSource = self
    }
    
 @objc  private func editingButtonTap() {
     let settingViewController = SettingViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: true)
    }
    
    private func setupUserParameters() {
        
        if userArray.count != 0 {
            userNameLabel.text = userArray[0].userFirstName + userArray[0].userSecondName
            userHeightLabel.text = "Weight: \(userArray[0].userHeight)"
            userWeightLabel.text = "Weight: \(userArray[0].userWeight)"
            targetLabel.text = "TARGET:\(userArray[0].userTarget) workouts"
            workoutTargetLabel.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
        }
    }

    //Получаем уникальные имена и добавляем их в массив
    private func getWorkoutName() -> [String] {
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    //  Получаем массив с уникальными именами и тренировками
    private func getWorkoutResults() {
        
        let nameArray = getWorkoutName()
        
        for name in nameArray {
            //get all value by name
            let predicateName = NSPredicate(format: "workoutName = '\(name)'")
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            workoutArray.forEach { model in
                result += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
}

extension ProfilViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCollectionViewCell, for: indexPath) as! ProfileCollectionViewCell
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialGreen : .specialDarkYellow)
        
        return cell
    }
}

extension ProfilViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.07, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.setProgress(0.6, animated: true)
    }
}

extension ProfilViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]) 
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 90),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            userPhotoView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 80),
            userPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userPhotoView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 40),
            userNameLabel.centerXAnchor.constraint(equalTo: userPhotoView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userParamStackView.topAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: 5),
            userParamStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
        editingButton.topAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: 5),
        editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        editingButton.heightAnchor.constraint(equalToConstant: 25),
        editingButton.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: userParamStackView.bottomAnchor, constant: 20),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
        targetStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 10),
        targetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        targetStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
        targetView.topAnchor.constraint(equalTo: targetStackView.bottomAnchor, constant: 3),
        targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        targetView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
        progressView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20),
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        progressView.heightAnchor.constraint(equalToConstant: 28)

        ])
    }
}
