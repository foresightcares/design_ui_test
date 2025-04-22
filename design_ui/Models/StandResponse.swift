import Foundation

struct ResponseData: Decodable {
    let received: String
    let standsNum: String

  enum CodingKeys: String, CodingKey {
        case received = "Received"
        case standsNum = "stands_num"
    }
}

struct StandResponse: Decodable {
  let response: ResponseData
}
