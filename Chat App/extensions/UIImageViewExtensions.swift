import Foundation
import UIKit

extension UIImageView{
    
    func loadImageFromUrl(_ imageUrl: String, _showSpinner: Bool = false) {
        //Add spinner code
        
        let url: URL! = URL(string: imageUrl)
print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
print(response?.suggestedFilename ?? url.lastPathComponent)
print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
