

import UIKit

protocol DataFetcherProtocol {
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcherProtocol {
    static let shared = NetworkDataFetcher()

  private let networking: NetworkingProtocol
  private init(networking: NetworkingProtocol = NetworkService()) {
    self.networking = networking
  }

    func fetchData<T: Codable>(from urlString: String, completion: @escaping (T?) -> Void) where T : Decodable, T : Encodable {
      networking.request(url: urlString) { data, error in
        if let error = error {
          print("DEBUG: fetch Error", error)
          completion(nil)
        }
        let decoded = self.decodeJson(type: T.self, from: data)
        completion(decoded)
      }
    }

  func decodeJson<T: Codable>(type: T.Type, from data: Data?) -> T? {
    guard let data = data else { return nil }
    do {
      let objects = try JSONDecoder().decode(type.self, from: data)
      return objects
    } catch let jsonError {
      print("DEBUG: jsonError is", jsonError)
      return nil
    }
  }
}


