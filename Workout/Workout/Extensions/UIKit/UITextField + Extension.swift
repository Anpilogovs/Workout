import Foundation
import UIKit

extension UITextField {
    
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.textColor = .specialGrey
        self.font = .robotoMedium20()
        self.leftView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 15,
                                             height: self.frame.height))
        self.leftViewMode = .always
        self.clearButtonMode = .always
        self.returnKeyType = .done
        self.keyboardType = .numberPad
    }
}
