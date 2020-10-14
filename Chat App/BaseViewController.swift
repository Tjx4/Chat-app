import UIKit

class BaseViewController: UIViewController {
 
      let spinner: SpinnerViewController  = SpinnerViewController()
        
    func showLoading() {
         addChild(spinner)
         spinner.view.frame = view.frame
         view.addSubview(spinner.view)
         spinner.didMove(toParent: self)
      }

    func hideLoading() {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
         }
      }

}
