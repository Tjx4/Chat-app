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
      
            login = try logInUser(usenrname, password)
      
            if login?.result ?? false {
                segueToScreen(segueIdentifier: "segueToFriends")
            }
          
          } catch {
             print("Login error", error)
          }
    }
    
    fileprivate func logInUser(_ username: String, _ password: String) throws -> Login {
               let semaphore = DispatchSemaphore(value: 0)
/*
            let semaphore = DispatchSemaphore(value: 0)
            
            let Url = String(format: HOST+""+LOGIN_USER)
            print(Url)
            
            guard let serviceUrl = URL(string: Url) else { return Login() }
        
            let parameters: [String: Any] = [
                "request": [
                        "xusercode" : username,
                        "xpassword": password
                ]
            ]
        
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return JSONDecoder().decode(Login.self,
                from: data!)
            }
        
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
        
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
                
                semaphore.signal()
                
            }.resume()
        }
                
      _ = semaphore.wait(timeout: .distantFuture)
*/
        var login = Login()
        login.result = true
        login.guid = "3f2504e0-4f89-11d3-9a0c-0305e82c3301"
        login.firstName = "John"
        login.lastName = "Appleseed"
        
        return login
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



