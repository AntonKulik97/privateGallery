
import Foundation
import UIKit

extension UIView{
    func buttonRadius(radius: CGFloat = 20, opacity: Float = 1){
        self.layer.cornerRadius = radius
        self.layer.opacity = opacity
    }
    func viewStyle(radius: CGFloat = 20, opacity: CGFloat = 1) {
        self.layer.cornerRadius = radius
        self.layer.opacity = Float(opacity)
    }

}

extension UIViewController{

func showAlert(title: String?,message: String?,prefferedStyle:UIAlertController.Style, firstButtonText: String?,firstButtonStyle: UIAlertAction.Style, firstButtonAction: ((UIAlertAction) -> Void)?,secondButtonText: String?,secondButtonStyle: UIAlertAction.Style, secondButtonAction: ((UIAlertAction) -> Void)?,thirdButtonText: String?,thirdButtonStyle: UIAlertAction.Style, thirdButtonAction: ((UIAlertAction) -> Void)?)  {
    let alertCntrl = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)
    let firstButton = UIAlertAction(title: firstButtonText, style:firstButtonStyle, handler: firstButtonAction)
    let secondButton = UIAlertAction(title: secondButtonText, style:secondButtonStyle, handler: secondButtonAction)
    let thirdButton = UIAlertAction(title: thirdButtonText, style: thirdButtonStyle, handler: thirdButtonAction)
    alertCntrl.addAction(firstButton)
    alertCntrl.addAction(secondButton)
    alertCntrl.addAction(thirdButton)
    self.present(alertCntrl,animated: true)
    }
}
extension UIViewController: UITextFieldDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
