import UIKit

class FriendsViewController : UIViewController {
    
    @IBOutlet weak var myFriendsTableView: UITableView!
    var friends: [Friend]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFriendsTableView.delegate = self as! UITableViewDelegate
        myFriendsTableView.dataSource = self as! UITableViewDataSource
        
        var friend1 = Friend()
        friend1.firstName = "Emma"
        friend1.lastName = "Griffin"
        friend1.alias = "emmathechick"
        friend1.dateOfBirth = "1970-01-01"
        friend1.imageURL = "http://api.randomuser.me/portraits/med/women/73.jpg"
        friend1.status = "Offline"
        friend1.lastSeen = "2014-07-15 12:08:00"
        
        var friend2 = Friend()
        friend2.firstName = "Guy"
        friend2.lastName = "Adams"
        friend2.alias = "thatsright_mynameisguy"
        friend2.dateOfBirth = "1969-07-31"
        friend2.imageURL = "http://api.randomuser.me/portraits/med/men/93.jpg"
        friend2.status = "Online"
        friend2.lastSeen = "2015-07-15 10:00:00"
        
        friends = [
            friend1,
            friend2
        ]
    }
    
     fileprivate func getFriends(_ uniqueId: String, _ name: String) throws -> [Friend] {
         let urlString = HOST+""+GET_FRIENDS
         print(urlString)
                 
         guard let url = URL(string: urlString) else {
             throw Networerror.url
         }
         
         var data: Data?
         var response: URLResponse?
         var error: Error?
         
         let semaphore = DispatchSemaphore(value: 0)
         
         URLSession.shared.dataTask(with: url) { (d, resp, err) in
             data = d
             response = resp
             error = err
             
             semaphore.signal()
         }.resume()
         
        _ = semaphore.wait(timeout: .distantFuture)
         
         if let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode > 200 {
             throw Networerror.statusCode
         }
         
         if error != nil{
             throw Networerror.generic
         }
         
         return try JSONDecoder().decode([Friend].self,
         from: data!)
     }
    
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        segueToScreen(segueIdentifier: "detailsSegue")
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = friends[indexPath.row].firstName
        return cell
    }
    
}
