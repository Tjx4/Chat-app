

import UIKit

class LoginViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var usernameUiTextField: ChatUITextField!
    
    @IBOutlet weak var passwordUiTextField: ChatUITextField!
    
    @IBAction func onLoginClicked(_ sender: Any) {
        segueToScreen(segueIdentifier: "segueToFriends")
    }
    
}



