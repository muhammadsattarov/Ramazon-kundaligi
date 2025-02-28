//
//  Netwo.swift
//  RamazonKundaligi
//
//  Created by user on 26/02/25.
//

import Foundation

// MARK: - NetworkingProtocol
protocol NetworkingProtocol {
  func request(url: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkingProtocol {

  func request(url: String, completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: url) else { return }
    let request = URLRequest(url: url)
    let task = createDataTask(from: request, completion: completion)
    task.resume()
  }

  func createDataTask(from request: URLRequest,
                      completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request) { data, _, error in
      DispatchQueue.main.async {
        completion(data, error)
      }
    }
  }
}
