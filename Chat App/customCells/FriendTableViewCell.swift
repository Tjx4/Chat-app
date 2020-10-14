
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
    
    public func config(with name: String?, imageUrl: String?, status: String?, lastSeen: String?, alias: String?){
        friendUILabel.text = name ?? ""
        aliasUILabel.text = alias == nil || alias?.isEmpty ?? true ?  "" : "@\(alias!)"
        friendProfpic.loadImageFromUrl(imageUrl ?? "")
        
        let lastSeen = lastSeen ?? ""
        let spl = (lastSeen.isEmpty) ? status ?? "" : "\(lastSeen.split(separator: " ")[0])"
        lastSeenUILabel.text = "\(spl)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
