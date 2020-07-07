
import UIKit

class LoginView: UIView {
    
   
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
     static func instanceFromNib() -> LoginView {
       return UINib(nibName: "LoginView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? LoginView ?? LoginView()
       }
    
    func setView(label: String = "Пароль, пожалуйста)", button: String = "Подтвердить", textField: String = "Введите пароль") {
        
        self.loginLabel.text = label
        self.loginButton.setTitle(button, for: .normal)
        self.loginTextField.placeholder = textField
        
        
    }
    func setBackButton(radius: Int = 20, opacity: Float = 1){
        self.backButton.buttonRadius(radius: CGFloat(radius) , opacity: opacity)
    }
    
    func setloginButton(radius: Int = 20, opacity: Float = 1){
        self.loginButton.buttonRadius(radius: CGFloat(radius) , opacity: opacity)
    }
}
