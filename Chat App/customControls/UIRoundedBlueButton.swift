import UIKit

@IBDesignable class UIRoundedBlueButton: UIButton
{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = hexStringToUIColor(hex: "#0088cc")
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
    

}
