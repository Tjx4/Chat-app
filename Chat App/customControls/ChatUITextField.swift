
import UIKit

class ChatUITextField: UITextField {
    
    override func layoutSubviews() {
         super.layoutSubviews()
        setLeftPaddingPoints(10)
        setRightPaddingPoints(10)
     }

    
    func setLeftPaddingPoints(_ amount:CGFloat){
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
          self.leftView = paddingView
          self.leftViewMode = .always
      }
      func setRightPaddingPoints(_ amount:CGFloat) {
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
          self.rightView = paddingView
          self.rightViewMode = .always
      }
    
}
