import UIKit

class LoginViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var usernameUiTextField: ChatUITextField!
    @IBOutlet weak var passwordUiTextField: ChatUITextField!
    @IBOutlet weak var errorUiLabel: UILabel!
    @IBOutlet weak var createAccountUILabel: UILabel!
    
    var errorMessage: String?
    
    @IBAction func onLoginClicked(_ sender: Any) {
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
      
            let logIn = try logInUser(usenrname, password)
      
            if logIn.result {
                segueToScreen(segueIdentifier: "segueToFriends")
            }
          
          } catch {
             print("Login error", error)
          }
    }
    
    fileprivate func logInUser(_ username: String, _ password: String) throws -> Login {
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
        return login
    }

    func checkIsValidUsername(_ username: String?) -> Bool {
        return username?.isValidUsername() ?? false
    }
    
    func checkIsValidPassword(_ password: String?) -> Bool {
        return password?.isValidPassword() ?? false
    }

}



