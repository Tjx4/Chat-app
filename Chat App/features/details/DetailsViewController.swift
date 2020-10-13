import UIKit

class DetailsViewController : UIViewController {
    
    @IBOutlet weak var userPicUIImageView: RoundedUIImageView!
    
    @IBOutlet weak var nameUILabel: UILabel!
    @IBOutlet weak var statusUILabel: UILabel!
    @IBOutlet weak var lastSeenUILabel: UILabel!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var dobUILabel: UILabel!
    
    var friend = Friend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        friend.firstName = "Emma"
        friend.lastName = "Griffin"
        friend.alias = "emmathechick"
        friend.dateOfBirth = "1970-01-01"
        friend.imageURL = "http://api.randomuser.me/portraits/med/women/73.jpg"
        friend.status = "Offline"
        friend.lastSeen = "2014-07-15 12:08:00"
        
        navBarTitle.title = friend.alias
        
        nameUILabel.text = "\(friend.firstName!) \(friend.lastName!)"
        dobUILabel.text = friend.dateOfBirth
        statusUILabel.text = friend.status
        lastSeenUILabel.text = "last seen on \(friend.lastSeen!)"
    userPicUIImageView.loadImageFromUrl(friend.imageURL ?? "")
    }
}
