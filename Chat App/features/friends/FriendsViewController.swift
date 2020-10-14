
import UIKit

class FriendsViewController : BaseViewController {
    
    @IBOutlet weak var friendsNavigationBar: UINavigationItem!
    @IBOutlet weak var myFriendsTableView: UITableView!
    
    var loginResponse: Login!
    var selectedIndex: Int!
    var friends: [Friend]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "logo_landscape.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let friendsNavigationController = self.navigationController as! FriendsNavigationController
        
        loginResponse = friendsNavigationController.loginResponse
        
        myFriendsTableView.register(FriendTableViewCell.nib(), forCellReuseIdentifier: FriendTableViewCell.identifier)
        myFriendsTableView.delegate = self as! UITableViewDelegate
        myFriendsTableView.dataSource = self as! UITableViewDataSource
        
        fetchFriends()
    }
    
    fileprivate func fetchFriends()  {
        do{
            showLoading()
            
            let response = try getFriends(loginResponse.guid ?? "", loginResponse.firstName ?? "")
            
            hideLoading()
            
            if response.result ?? false {
                friends = response.friends
            }
            else{
                showErrorAndTryAgain()
            }
            
        } catch {
            self.hideLoading()
            showErrorAndTryAgain()
        }
    }
    
    func showErrorAndTryAgain(){
        showSingleActionUIAlert(self, "Error", "Error getting friends", "try again",  leftActionHandler:{ (action) -> Void in
                       self.fetchFriends()
                   })
    }
    
     fileprivate func getFriends(_ uniqueId: String, _ name: String) throws -> FriendsResponse {
         let urlString = HOST+""+GET_FRIENDS+"?name="+name+";uniqueID="+uniqueId
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
         
         return try JSONDecoder().decode(FriendsResponse.self,
         from: data!)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "detailsSegue" {
              let detailsViewController = segue.destination as! DetailsViewController
              detailsViewController.friend =  friends![selectedIndex]
          }
      }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
          segueToScreen(segueIdentifier: "segueToLogin")
    }
    
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        selectedIndex = indexPath.item
        segueToScreen(segueIdentifier: "detailsSegue")
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let friendTableViewCell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
        
        let friend: Friend? = friends?[indexPath.row]
        
        let fullname = "\(friend!.firstName!) \(friend!.lastName!) "
        friendTableViewCell.config(with: fullname, imageUrl: friend?.imageURL, status: friend?.status ,lastSeen: friend?.lastSeen, alias: friend?.alias)
            
             return friendTableViewCell
    }
    
}
