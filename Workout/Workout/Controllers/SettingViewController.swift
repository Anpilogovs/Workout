//
//  SettingViewController.swift
//  Workout
//
//  Created by Сергей Анпилогов on 31.01.2023.
//
import Foundation
import UIKit
import RealmSwift


class SettingViewController: UIViewController {
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "EDITING PROFILE"
        label.textColor = .specialGrey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
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
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let firstNameLabel = UILabel(text: "  First name")
    private let firstNameTextField = UITextField(color: .specialGrey)
    
    private let secondNameLabel = UILabel(text: "  Second name")
    private let secondTextField = UITextField(color: .specialGrey)
    
    private let heightLabel = UILabel(text: "   Height")
    private let heightTextField = UITextField(color: .specialGrey)
    
    private let weighttLabel = UILabel(text: "   Weight")
    private let weightTextField = UITextField(color: .specialGrey)

    private let targetLabel = UILabel(text: "   Target")
    private let targetTextField = UITextField(color: .specialGrey)
    
    private  var firstNameStackView = UIStackView()
    private  var secondNameStackView = UIStackView()
    private  var heightStackView = UIStackView()
    private  var weightStackView = UIStackView()
    private  var targetStackView = UIStackView()
    private  var generalStackView = UIStackView()
    
    private let localRealm = try! Realm()
    private var userArray: Results<UserModel>!
    
    private var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupContraints()
        addTap()
        
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
            weightStackView, targetStackView], axis: .vertical, spacing: 3)
        
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
    
    private func addTap() {
        
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
    
    @objc func finishButtonTapped() {
        
    }
}

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
extension SettingViewController {
    private func setupContraints() {
        
    }
}
