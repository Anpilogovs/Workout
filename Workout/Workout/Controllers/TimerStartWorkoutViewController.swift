//
//  TimerStartViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 24.01.2023.
//

import Foundation
import UIKit


class TimerStartWorkoutViewController: UIViewController {
    
    private let startWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.textAlignment = .center
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  let closeScreenButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeScreenButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let  ellipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipsee")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "01:30"
        label.tintColor = .specialBrown
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .specialGreen
        button.titleLabel?.font = .robotoMedium16()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let detailLabel = UILabel(text: "Details")
    
    private let timerWorkoutView = TimerStartView()
    var timerWorkoutModel = WorkoutModel()
    let customAlert = CustomAlert()
    
    var timer = Timer()
    var durationTimer = 10
    let shapeLayer = CAShapeLayer()
    private var numberOfSet = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeScreenButton.layer.cornerRadius = closeScreenButton.frame.width / 2
        animtaionCircle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        setupContraints()
        setDelegate()
        addTaps()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackgound
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeScreenButton)
        view.addSubview(ellipseImageView)
        view.addSubview(timerNumberLabel)
        view.addSubview(detailLabel)
        view.addSubview(timerWorkoutView)
        view.addSubview(finishButton)
        
        setupWorkoutParametersForScreenWithTimer()
    }
    
    private func setDelegate() {
        timerWorkoutView.nextSetDelegate = self
    }
    
    @objc func finishButtonTapped() {
        if numberOfSet == timerWorkoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: timerWorkoutModel, bool: true)
        } else {
            alertOk(title: "Warning", message: "You haven't finished your")
            self.dismiss(animated: true)
        }
        
        timer.invalidate()
    }
    
    @objc func closeScreenButtonTapped() {
        dismiss(animated: true)
        timer.invalidate()
    }
    
    private func setupWorkoutParametersForScreenWithTimer() {

        timerWorkoutView.nameLabel.text = timerWorkoutModel.workoutName
        timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(timerWorkoutModel.workoutSets)"
        let (min, sec) = timerWorkoutModel.workoutTimer.convertSeconds()
        timerWorkoutView.timeOfSetNumberLabel.text = "\(min) min \(sec) sec"
        
        timerNumberLabel.text = "\(min):\(sec.setZeroForSeconds())"
        durationTimer = timerWorkoutModel.workoutTimer
    }
    
    private func addTaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerNumberLabel.isUserInteractionEnabled = true
        timerNumberLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        
        timerWorkoutView.editingButton.isEnabled = false
        timerWorkoutView.nextSetButton.isEnabled = false
        
        if numberOfSet == timerWorkoutModel.workoutSets {
            alertOk(title: "", message: "Finish your workout")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate() //Reset
            durationTimer = timerWorkoutModel.workoutTimer
            
            numberOfSet += 1
            timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(timerWorkoutModel.workoutSets)"
            timerWorkoutView.editingButton.isEnabled = true
            timerWorkoutView.nextSetButton.isEnabled = true
        }
        
        let (min, sec) = durationTimer.convertSeconds()
        timerNumberLabel.text = "\(min):\(sec.setZeroForSeconds())"
    }
}
//MARK: - Animation

extension TimerStartWorkoutViewController {
    
    private func animtaionCircle() {
        
        let center = CGPoint(x: ellipseImageView.frame.width / 2,
                             y: ellipseImageView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circlePath = UIBezierPath(arcCenter: center,
                                  radius: 135,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: false)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        ellipseImageView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

extension TimerStartWorkoutViewController: nextSetForScreenWithTimerProtocol {
    
    func nextSetButtonForTimerViewControllerTapped() {
        if numberOfSet < timerWorkoutModel.workoutSets {
            numberOfSet += 1
            timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(timerWorkoutModel.workoutSets)"
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }
    
    func editingButtonForTimeViewControllerTap() {
        
        customAlert.alertCustom(viewController: self, repsOrTimer: "Timer of set") { [self] sets, timeOfSet in
            
            if sets != "" && timeOfSet != "" {
                guard let numberOfSets = Int(sets) else { return }
                guard let timer = Int(timeOfSet) else { return }
                let (min, sec) = numberOfSets.convertSeconds()
                timerWorkoutView.setsNumberLabel.text = "\(numberOfSet)/\(sets)"
                timerWorkoutView.timeOfSetNumberLabel.text = "\(min) min \(sec) sec"
                timerNumberLabel.text = "\(min):\(sec.setZeroForSeconds())"
                durationTimer = timer
                RealmManager.shared.updateSetsAndRepsWorkoutModel(model: timerWorkoutModel,
                                                                  sets: numberOfSets,
                                                                  reps: timer)
            }
        }
    }
}

extension TimerStartWorkoutViewController {
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeScreenButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeScreenButton.heightAnchor.constraint(equalToConstant: 30),
            closeScreenButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            ellipseImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            ellipseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ellipseImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            timerNumberLabel.centerYAnchor.constraint(equalTo: ellipseImageView.centerYAnchor),
            timerNumberLabel.leadingAnchor.constraint(equalTo: ellipseImageView.leadingAnchor, constant: 40),
            timerNumberLabel.trailingAnchor.constraint(equalTo: ellipseImageView.trailingAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: ellipseImageView.bottomAnchor, constant: 30),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            timerWorkoutView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5),
            timerWorkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerWorkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerWorkoutView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
