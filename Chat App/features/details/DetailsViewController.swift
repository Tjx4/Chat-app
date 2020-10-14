import UIKit

class DetailsViewController : UIViewController {
    
    @IBOutlet weak var userPicUIImageView: RoundedUIImageView!
    
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var statusUILabel: UILabel!
    @IBOutlet weak var lastSeenUILabel: UILabel!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var dobUILabel: UILabel!
    
    var friend:Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.title = friend.alias
        
        nameUILabel.text = "\(friend.firstName!) \(friend.lastName ?? "")"
        dobUILabel.text = friend.dateOfBirth
        statusUILabel.text = friend.status
        lastSeenUILabel.text = "last seen on \(friend.lastSeen ?? "")"
        userPicUIImageView.loadImageFromUrl(friend.imageURL ?? "")
        lastSeenUILabel.isHidden = friend.lastSeen == nil
    }
}
