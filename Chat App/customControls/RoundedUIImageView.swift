import UIKit

@IBDesignable class RoundedUIImageView: UIImageView
{
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
    }
}
