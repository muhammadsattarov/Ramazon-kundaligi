import Foundation


protocol RamadanServiceProtocol {
  func fetchRegions(completion: @escaping (Result<[Region], Error>) -> Void)
  func fetchDistricts(_ id: Int, completion: @escaping (Result<[District], Error>) -> Void)
  func fetchRamadanSchedule(_ id: Int, completion: @escaping (Result<RamazonTaqvim, Error>) -> Void)
}

class RamadanService: RamadanServiceProtocol {
  static let shared = RamadanService()

  private let network: NetworkServiceProtocol
  private init(network: NetworkServiceProtocol = NetworkService.shared) {
    self.network = network
  }

  func fetchRegions(completion: @escaping (Result<[Region], Error>) -> Void) {
    let entPoint = Constants.regionsUrl
    network.fetchData(from: entPoint, completion: completion)
  }

  func fetchDistricts(_ id: Int,
                      completion: @escaping (Result<[District], Error>) -> Void) {
    let entPoint = "\(Constants.districtUrl)\(id)"
    network.fetchData(from: entPoint, completion: completion)
  }

  func fetchRamadanSchedule(_ id: Int, completion: @escaping (Result<RamazonTaqvim, Error>) -> Void) {
    let entPoint = "\(Constants.ramadanScheduleUrl)\(id)"
    network.fetchData(from: entPoint, completion: completion)
  }
}

