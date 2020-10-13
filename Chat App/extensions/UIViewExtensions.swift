import UIKit

extension UIView{
    func rotate(_ toDegree: Double, _ repeatCount: Int) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: toDegree)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float(repeatCount)
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func blink() {
         self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
        
   }
    
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
          UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
              self.alpha = alpha
          })
        
      }
    
}
