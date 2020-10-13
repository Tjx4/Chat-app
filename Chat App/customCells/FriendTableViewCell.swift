
import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let identifier = "FriendTableViewCell"
    @IBOutlet var  friendName:UILabel!
    @IBOutlet var  friendProfpic:RoundedUIImageView!
    
    static func nib() -> UINib{
        return UINib(nibName: "FriendTableViewCell", bundle: nil)
    }
    
    public func config(with name: String, imageUrl: String){
        friendName.text = name
        friendProfpic.loadImageFromUrl(imageUrl)
        // friendProfpic.image = UIImage(contentsOfFile: "user_icon")
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
