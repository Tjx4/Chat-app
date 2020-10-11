
import UIKit

@IBDesignable class ChatUITextField: UITextField {
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = hexStringToUIColor(hex: "#f4f4f6")
        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? 5 : 0
    }
    
    
    /*
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
    */
    
}
