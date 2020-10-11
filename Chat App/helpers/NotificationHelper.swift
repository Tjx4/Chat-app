import Foundation
import UIKit

public func showUIAlert(_ view: UIViewController, _ title: String, _ message: String, _ leftButtonText: String, _ rightButtonText: String, leftActionHandler: ((UIAlertAction) -> Void)? = nil, rightActionHandler: ((UIAlertAction) -> Void)? = nil){
    
   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
   alert.addAction(UIAlertAction(title: rightButtonText, style: .default, handler: rightActionHandler))
   alert.addAction(UIAlertAction(title: leftButtonText, style: .cancel, handler: leftActionHandler))
   view.present(alert, animated: true)
}

public func showSingleActionUIAlert(_ view: UIViewController, _ title: String, _ message: String, _ leftButtonText: String, leftActionHandler: ((UIAlertAction) -> Void)? = nil){
    
   let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
   alert.addAction(UIAlertAction(title: leftButtonText, style: .cancel, handler: leftActionHandler))
   view.present(alert, animated: true)
}

public func showActionSheet(_ viewController:UIViewController){
    // create an actionSheet
    let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    // create an action
    let firstAction: UIAlertAction = UIAlertAction(title: "First Action", style: .default) { action -> Void in

        print("First Action pressed")
    }

    let secondAction: UIAlertAction = UIAlertAction(title: "Second Action", style: .default) { action -> Void in

        print("Second Action pressed")
    }

    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

    actionSheetController.addAction(firstAction)
    actionSheetController.addAction(secondAction)
    actionSheetController.addAction(cancelAction)

    viewController.present(actionSheetController, animated: true) {
        print("option menu presented")
    }
}
