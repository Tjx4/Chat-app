import Foundation

extension String {
    func isValidUsername() -> Bool{
       return self.count > 1
    }
    
    public func isValidPassword() -> Bool {
        //For demo purposes
        return self.count > 1
    }
}
