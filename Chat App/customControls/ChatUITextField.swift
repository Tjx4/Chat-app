
import UIKit

@IBDesignable class ChatUITextField: UITextField {
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = hexStringToUIColor(hex: "#f4f4f6")
        updateCornerRadius()
        setBorder()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? 5 : 0
    }
    
    
    func setBorder() {
        layer.borderWidth = 2
        layer.borderColor = hexStringToUIColor(hex:"#f4f4f6").cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
         return CGRect(
             x: bounds.origin.x + 15,
             y: bounds.origin.y + 15,
             width: bounds.size.width - 15 * 2,
             height: bounds.size.height - 15 * 2
         )
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return self.textRect(forBounds: bounds)
     }
    
    
    
}
