import UIKit


final class DateAndRepeatView: UIView {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .robotoMedium18()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var repeatEveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat every 7 days"
        label.font = .robotoMedium18()
        label.textColor = .specialBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
     lazy var repeatSwitches: UISwitch = {
        let switches = UISwitch()
        switches.isOn = true
        switches.tintColor = .specialGreen
        switches.translatesAutoresizingMaskIntoConstraints = false
        return switches
    }()
    
    private lazy var dateStackView = UIStackView()
    private lazy var repeatStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        dateStackView =  UIStackView(arrangedSubviews: [dateLabel,datePicker],
                                     axis: .horizontal, spacing: 10)
        repeatStackView = UIStackView(arrangedSubviews: [repeatEveryLabel,repeatSwitches],
                                      axis: .horizontal, spacing: 10)
        
        addSubview(dateStackView)
        addSubview(repeatStackView)
    }
}

//MARK: - setupContraints
extension DateAndRepeatView {
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
