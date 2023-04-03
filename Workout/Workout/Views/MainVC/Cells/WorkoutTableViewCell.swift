import UIKit

protocol StartWorkoutProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
    
}

final class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialLightBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackgound
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        imageView.contentMode  = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.textColor = .specialGrey
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: "
        label.textColor = .specialGrey
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: "
        label.textColor = .specialGrey
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.addShadowOnView()
        button.layer.cornerRadius = 10
        button.backgroundColor = .specialGreen
        button.tintColor = .white
        button.setTitle("COMPLETE", for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTrapped), for: .touchUpInside)
        return button
    }()
    
    private var labelsStackView = UIStackView()
    private var workoutModel = WorkoutModel()
    
    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        addSubview(workoutImageView)
        addSubview(workoutNameLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        
        addSubview(labelsStackView)
        //        It is advisable to add button to ContentView
        contentView.addSubview(startButton)
    }
    
    @objc func startButtonTrapped() {
        
        cellStartWorkoutDelegate?.startButtonTapped(model: workoutModel)
    }
    
   public func cellConfigure(model: WorkoutModel) {
        workoutModel = model
        workoutNameLabel.text = model.workoutName
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(model.workoutTimer)
        
        workoutRepsLabel.text = (model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec")
        workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        
        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData ) else { return }
        workoutImageView.image = image
        
        if model.status {
            
            startButton.setTitle("COMPLETE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
    }
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

