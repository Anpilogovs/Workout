import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
  private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "We"
        label.font = .robotoMedium16()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.text = "29"
        label.font = .robotoMedium20()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected  {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                backgroundColor = .specialGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }
    
   public func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
