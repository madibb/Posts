import Foundation

public struct JSONDecoderFactory {

    public static func make() -> JSONDecoder {

        let jsonDecoder = JSONDecoder()

        return jsonDecoder
    }
}
