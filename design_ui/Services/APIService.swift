import Foundation

struct APIService {
  let apiURL = URL(string: "https://interfaces.foresightcares.com/test_api")
  
  func fetchData() async throws -> StandResponse {
    guard let url = apiURL else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoder = JSONDecoder()
    return try decoder.decode(StandResponse.self, from: data)
  }
  
  func postData(with message: String) async throws -> StandResponse {
    guard let url = apiURL else {
      throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: String] = ["message": message]
    request.httpBody = try JSONSerialization.data(withJSONObject: body)
    
    let (data, _) = try await URLSession.shared.upload(for: request, from: request.httpBody!)
    let decoder = JSONDecoder()
    return try decoder.decode(StandResponse.self, from: data)
  }
}
