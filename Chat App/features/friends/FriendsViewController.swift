import UIKit

class FriendsViewController : UIViewController {
    
    @IBOutlet weak var myFriendsTableView: UITableView!
    
    let names = [
        "Tshepo",
        "Nomvula",
        "Masingita"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFriendsTableView.delegate = self as! UITableViewDelegate
        myFriendsTableView.dataSource = self as! UITableViewDataSource
    }
    
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
}
