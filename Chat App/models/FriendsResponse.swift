import Foundation

struct FriendsResponse: Codable {
    var result: Bool? = false
    var friends: [Friend]? = nil
}
