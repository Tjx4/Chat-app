import UIKit

@IBDesignable class UIRoundedGreenButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = hexStringToUIColor(hex: "#008577")
        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
