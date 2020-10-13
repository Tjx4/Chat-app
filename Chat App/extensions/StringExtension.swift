import Foundation

extension String {
    func isValidUsername() -> Bool{
       return self.count > 1
    }
    
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
       // return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)

        return self.count > 1
    }
}
