import Foundation


protocol RamadanServiceProtocol {
  func fetchRegions(completion: @escaping ([Region]?) -> Void)
  func fetchDistricts(_ id: Int, completion: @escaping ([District]?) -> Void)
  func fetchRamadanSchedule(_ id: Int, completion: @escaping (RamazonTaqvim?) -> Void)
}

class RamadanService: RamadanServiceProtocol {
  static let shared = RamadanService()

  private let datafetcher: DataFetcherProtocol
  private init(datafetcher: DataFetcherProtocol = NetworkDataFetcher.shared) {
    self.datafetcher = datafetcher
  }

  func fetchRegions(completion: @escaping ([Region]?) -> Void) {
    let entPoint = Constants.regionsUrl
    datafetcher.fetchDataArray(from: entPoint, completion: completion)
  }

  func fetchDistricts(_ id: Int,
                      completion: @escaping ([District]?) -> Void) {
    let entPoint = "\(Constants.districtUrl)\(id)"
    datafetcher.fetchDataArray(from: entPoint, completion: completion)
  }

  func fetchRamadanSchedule(_ id: Int, completion: @escaping (RamazonTaqvim?) -> Void) {
    let entPoint = "\(Constants.ramadanScheduleUrl)\(id)"
    datafetcher.fetchData(from: entPoint, completion: completion)
  }

  func fetchCurrentDay( _ id: Int, completion: @escaping (CurrentDay?) -> Void) {
    let entPoint = "\(Constants.ramadanCurrentDayUrl)\(id)"
    datafetcher.fetchData(from: entPoint, completion: completion)
  }
}

