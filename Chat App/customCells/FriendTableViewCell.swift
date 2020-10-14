
import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let identifier = "FriendTableViewCell"
    @IBOutlet weak var lastSeenUILabel: UILabel!
    @IBOutlet weak var friendUILabel: UILabel!
    @IBOutlet weak var aliasUILabel: UILabel!
    @IBOutlet weak var  friendProfpic: RoundedUIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "FriendTableViewCell", bundle: nil)
    }
    
    public func config(with name: String?, imageUrl: String?, lastSeen: String?, alias: String?){
        friendUILabel.text = name ?? ""
        aliasUILabel.text = alias ?? ""
        friendProfpic.loadImageFromUrl(imageUrl ?? "")
        var spl = lastSeen?.split(separator: " ")[1] ?? ""
        lastSeenUILabel.text = "\(spl)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
      
       // friendProfpic.loadImageFromUrl(friends[indexPath.row].imageURL ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
