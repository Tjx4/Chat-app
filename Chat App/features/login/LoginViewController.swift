import UIKit

class LoginViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var usernameUiTextField: ChatUITextField!
    
    @IBOutlet weak var passwordUiTextField: ChatUITextField!
    
    @IBAction func onLoginClicked(_ sender: Any) {
        checkAndLogin()
    }
    
    func checkAndLogin() {
        let logIn = Login()

        let usenrname: String = usernameUiTextField.text ?? ""
        let password: String = passwordUiTextField.text ??  ""
        
        do{
            let logIn = try logInUser(usenrname, password)
            let isSuccesful = logIn.isSuccesful
            
            if isSuccesful {
                segueToScreen(segueIdentifier: "segueToFriends")
            }
          
          } catch {
             print("Login error", error)
          }
    }
    
    fileprivate func logInUser(_ username: String, _ password: String) throws -> Login {
        let urlString = HOST+""+LOGIN_USER
        print(urlString)
                
        guard let url = URL(string: urlString) else {
            throw Networerror.url
        }
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (d, resp, err) in
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
}



