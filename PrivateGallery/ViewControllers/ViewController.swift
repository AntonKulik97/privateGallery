
import UIKit
import SwiftyKeychainKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var entranceButton: UIButton!
    @IBOutlet weak var smartEntranceButton: UIButton!
    private var loginView: LoginView!
    
    let service = Keychain(service: "com.PrivateGallery")
    let key = KeychainKey<String>(key: "myKey")
    let myContext:LAContext = LAContext()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.entranceButton.buttonRadius(radius: 25, opacity: 1)
        self.setupVisualEffectView()
        self.smartEntranceConfigure()
        try? service.set("0508", for: key)
        
    }
    
    @IBAction func smartEntranceButtonPressed(_ sender: UIButton) {
        
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            myContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Your Account") { (correct, nil) in
                if correct{
                    
                    DispatchQueue.main.async {
                        guard let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else{return}
                        self.navigationController?.pushViewController(mainController, animated: true)
                    }
                    
                }else {
                    print("Invalid password")
                }
            }
        }else{
            print("Does't support biometric")
        }
        
    }
    
    @IBAction func entranceButtonPressed(_ sender: UIButton) {
        self.setLoginView()
        self.animateIn()
    }
    
    @IBAction func backButtonPressed(){
        self.animateOut()
    }
    
    @IBAction func loginButtonPressed(){
        
        if passwordCheck() {
            self.animateOut()
            guard let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else{return}
            self.navigationController?.pushViewController(mainController, animated: true)
        }else{
            loginView.loginLabel.text = "Пароль неверный!"
            loginView.loginLabel.textColor = .red
        }
    }
    
    func smartEntranceConfigure(){
        smartEntranceButton.buttonRadius(radius: 25, opacity: 1)
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            if myContext.biometryType == .faceID{
                smartEntranceButton.setBackgroundImage(UIImage(named:"face_id"), for: UIControl.State.normal)
            }else if myContext.biometryType == .touchID{
                smartEntranceButton.setBackgroundImage(UIImage(named: "touch_id"), for: UIControl.State.normal)
            }
            else if myContext.biometryType == .none{
                smartEntranceButton.removeFromSuperview()
            }
        }
    }
    
    func setupVisualEffectView(){
        
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
        
    }
    
    func animateIn() {
        loginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        loginView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.loginView.alpha = 1
            self.loginView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.loginView.alpha = 0
            self.loginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
        }) { (_) in
            
            
            self.loginView.removeFromSuperview()
        }
    }
    
    func setLoginView(){
        loginView = LoginView.instanceFromNib()
        loginView.center = CGPoint(x: view.center.x, y: view.center.y - 55)
        loginView.frame.size = CGSize(width: self.loginView.frame.size.width, height: self.loginView.frame.size.height)
        loginView.setView()
        loginView.setBackButton(radius: 15, opacity: 1)
        loginView.setloginButton()
        loginView.viewStyle()
        loginView.backButton.addTarget(self, action:#selector(backButtonPressed), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        self.view.addSubview(loginView)
        
    }
    
    func passwordCheck() -> Bool {
        
        let password = try? service.get(key)
        if loginView.loginTextField.text == password {
            return true
        }else{return false}
        
    }
    
}


