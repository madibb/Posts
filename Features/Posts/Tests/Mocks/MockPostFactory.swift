import Foundation
import Models
import Utils

struct MockPostFactory {
    
    private static var post1 = """
    {
      "userId": 1,
      "id": 4,
      "title": "eum et est occaecati",
      "body": "ullam et saepe reiciendis voluptatem adipisci"
    }
    """

    private static var post2 = """
    {
      "userId": 1,
      "id": 7,
      "title": "magnam facilis autem",
      "body": "dolore placeat quibusdam"
    }
    """

    private static func post(_ json: String) -> Post {
        try! JSONDecoderFactory.make().decode(Post.self, from: json.data(using: .utf8)!)
    }

    static func makePost2() -> Post {
        post(post1)
    }

    static func makePost1() -> Post {
        post(post2)
    }
}
