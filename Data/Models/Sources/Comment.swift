import Foundation

public struct Comment: Decodable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
}
