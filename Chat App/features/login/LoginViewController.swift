import UIKit

class LoginViewController: BaseViewController, CAAnimationDelegate {
    @IBOutlet weak var usernameUiTextField: ChatUITextField!
    @IBOutlet weak var passwordUiTextField: ChatUITextField!
    @IBOutlet weak var errorUiLabel: UILabel!
    @IBOutlet weak var forgotPasswordUILabel: UILabel!
    @IBOutlet weak var createAccountUILabel: UILabel!
    
    var login: Login?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameUiTextField.delegate = self
        passwordUiTextField.delegate = self
        
        let createAccounTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onForgotPasswordLabelTapped(tapGestureRecognizer:)))
            createAccountUILabel.isUserInteractionEnabled = true
            createAccountUILabel.addGestureRecognizer(createAccounTapGestureRecognizer)
        
        let forgotPassTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCreateAccountLabelTapped(tapGestureRecognizer:)))
            forgotPasswordUILabel.isUserInteractionEnabled = true
            forgotPasswordUILabel.addGestureRecognizer(forgotPassTapGestureRecognizer)
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameUiTextField {
            textField.resignFirstResponder()
            passwordUiTextField.becomeFirstResponder()
        }
        else if textField == passwordUiTextField {
            textField.resignFirstResponder()
        }
        else{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        return true
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        checkAndLogin()
    }
    
    func checkAndLogin() {
        let usenrname: String = usernameUiTextField.text ?? ""
        let password: String = passwordUiTextField.text ?? ""
        
        do{
            if !checkIsValidUsername(usenrname) {
                errorUiLabel.text = "Please enter a valid username"
                errorUiLabel.blink()
                return
            }
        
            if !checkIsValidPassword(password) {
                errorUiLabel.text = "Please enter a valid password"
                errorUiLabel.blink()
                return
            }
      
            showLoading()
           
            login = try logInUser(usenrname, password)
            
            hideLoading()
      
            if login?.result ?? false {
                segueToScreen(segueIdentifier: "segueToFriends")
            }
            else{
                errorUiLabel.text = "\(login?.error ?? "")"
                errorUiLabel.blink()
            }
          
        } catch {
            print("Login error", error)
        }
    }
    
    fileprivate func logInUser(_ username: String, _ password: String) throws -> Login {
        let parameters: [String: Any] = [
            "username" : username,
            "password" : password
        ]
        
        let Url = String(format: HOST+LOGIN_USER)
        guard let serviceUrl = URL(string: Url) else { return Login() }

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            var errorLogin = Login()
            errorLogin.error = "Unknown error"
            return errorLogin
        }

        request.httpBody = httpBody
        request.timeoutInterval = 20

        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: request) { (d, resp, err) in
          data = d
          response = resp
          error = err
          
          semaphore.signal()
        }.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        if let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode > 200 {
          throw Networerror.statusCode
        }

        if error != nil{
          throw Networerror.generic
        }

        return try JSONDecoder().decode(Login.self,
        from: data!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFriends" {
            let friendsNavigationController = segue.destination as! FriendsNavigationController
            let friendsViewController = friendsNavigationController
            friendsViewController.loginResponse = login
        }
    }
    
    @objc func onForgotPasswordLabelTapped(tapGestureRecognizer: UITapGestureRecognizer){
        showSingleActionUIAlert(self, "Alert", "Action not available in demo", "Close")
    }

    @objc func onCreateAccountLabelTapped(tapGestureRecognizer: UITapGestureRecognizer){
           showSingleActionUIAlert(self, "Alert", "Action not available in demo", "Close")
       }
    
    func checkIsValidUsername(_ username: String?) -> Bool {
        return username?.isValidUsername() ?? false
    }
    
    func checkIsValidPassword(_ password: String?) -> Bool {
        return password?.isValidPassword() ?? false
    }
      
}



