
import UIKit


extension UIViewController {
    
    private func segueToViewController(segueIdentifier: String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func segueToViewControllerWithNoPayload(segueIdentifier: String){
        segueToViewController(segueIdentifier: segueIdentifier)
    }
    
    func segueToScreen(segueIdentifier: String, payload: Any? = nil){
         segueToViewController(segueIdentifier: segueIdentifier)
     }
    
    
}
