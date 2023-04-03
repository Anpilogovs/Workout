import Foundation
import UIKit
import RealmSwift


final class SettingViewController: UIViewController {
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "EDITING PROFILE"
        label.textColor = .specialGrey
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.image = UIImage(named: "addPhoto")
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .specialGreen
        button.titleLabel?.font = .robotoMedium16()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let firstNameLabel = UILabel(text: "  First name")
    private let firstNameTextField = UITextField(color: .specialLightBrown)
    private let secondNameLabel = UILabel(text: "  Second name")
    private let secondTextField = UITextField(color: .specialLightBrown)
    private let heightLabel = UILabel(text: "   Height")
    private let heightTextField = UITextField(color: .specialLightBrown)
    private let weighttLabel = UILabel(text: "   Weight")
    private let weightTextField = UITextField(color: .specialLightBrown)
    private let targetLabel = UILabel(text: "   Target")
    private let targetTextField = UITextField(color: .specialLightBrown)
    private var firstNameStackView = UIStackView()
    private var secondNameStackView = UIStackView()
    private var heightStackView = UIStackView()
    private var weightStackView = UIStackView()
    private var targetStackView = UIStackView()
    private var generalStackView = UIStackView()
    
    private let localRealm = try! Realm()
    private var userArray: Results<UserModel>!
    
    private var userModel = UserModel()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addPhotoImageView.layer.cornerRadius = addPhotoView.frame.height / 2
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        addTaps()
        
        userArray = localRealm.objects(UserModel.self)
        loadUserInfo()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackgound
        
        view.addSubview(editingProfileLabel)
        view.addSubview(closeButton)
        view.addSubview(addPhotoView)
        view.addSubview(addPhotoImageView)
        
        firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField], axis: .vertical, spacing: 3)
        
        secondNameStackView = UIStackView(arrangedSubviews: [secondNameLabel, secondTextField], axis: .vertical, spacing: 3)
        
        heightStackView = UIStackView(arrangedSubviews: [heightLabel, heightTextField], axis: .vertical, spacing: 3)
        
        weightStackView = UIStackView(arrangedSubviews: [weighttLabel, weightTextField], axis: .vertical, spacing: 3)
        
        targetStackView = UIStackView(arrangedSubviews: [targetLabel, targetTextField], axis: .vertical, spacing: 3)
        
        generalStackView = UIStackView(arrangedSubviews: [
            firstNameStackView,
            secondNameStackView,
            heightStackView,
            weightStackView, targetStackView], axis: .vertical, spacing: 20)
        
        view.addSubview(generalStackView)
        view.addSubview(saveButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        setUserModel()
        
        if userArray.count == 0 {
            RealmManager.shared.saveUserModel(model: userModel)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
        }
        userModel = UserModel()
    }
    
    private func  loadUserInfo() {
        if userArray.count != 0 {
            firstNameTextField.text = userArray[0].userFirstName
            secondTextField.text = userArray[0].userSecondName
            heightTextField.text = "\(userArray[0].userHeight)"
            weightTextField.text = "\(userArray[0].userWeight)"
            targetTextField.text = "\(userArray[0].userTarget)"
            
            guard let date = userArray[0].userImage else { return }
            guard let image = UIImage(data: date) else { return }
            addPhotoImageView.image = image
            addPhotoImageView.contentMode = .scaleAspectFit
        }
    }
    
    private func setUserModel() {
        
        guard let firsName = firstNameTextField.text,
              let secondName = secondTextField.text,
              let height = heightTextField.text,
              let weight = weightTextField.text,
              let target = targetTextField.text else {
            return
        }
        
        guard let intHeight = Int(height),
              let intWeight = Int(weight),
              let intTarget = Int(target) else {
            return
        }
        
        userModel.userFirstName = firsName
        userModel.userSecondName = secondName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = intTarget
        
        if addPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.userImage = nil
        } else {
            guard let imageData = addPhotoImageView.image?.pngData() else { return }
            userModel.userImage = imageData
        }
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        addPhotoImageView.isUserInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        alertPhotoOrCamera { [weak self] source in
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
}
//MARK: - UIImagePickerControllerDelegate
extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        addPhotoImageView.image = image
        addPhotoImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)
    }
}
//MARK: - SetupContraints
extension SettingViewController {
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: editingProfileLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor,constant: 50),
            addPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPhotoView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoImageView.topAnchor.constraint(equalTo: addPhotoView.topAnchor,constant: -35),
            addPhotoImageView.centerXAnchor.constraint(equalTo: addPhotoView.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 70),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            secondTextField.heightAnchor.constraint(equalToConstant: 40),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            targetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            generalStackView.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor,constant: 5),
            generalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: generalStackView.bottomAnchor,constant: 5),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
