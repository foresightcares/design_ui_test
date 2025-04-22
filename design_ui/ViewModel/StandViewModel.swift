import SwiftUI

@MainActor
class StandViewModel: ObservableObject {
  
  
    //MARK: - Phase I
  @Published var receivedMessage: String = ""
  @Published var standsCount: String = ""
  @Published var isLoading: Bool = false // Set loading state to false after successful fetch
  
  
    //MARK: - Phase II
  @Published var messageToSend: String = ""
  @Published var isPosting: Bool = false // To indicate posting state
  
  
  private let apiService = APIService()
  
  func fetchData() async {
    self.isLoading = true
    do {
      let response = try await apiService.fetchData()
      self.receivedMessage = response.response.received
      self.standsCount = response.response.standsNum
      self.isLoading = false // Set loading state to false after successful fetch
    } catch {
      print("Error fetching data: \(error)")
      self.isLoading = false // Ensure loading state is false even on error
    }
  }
  
  func postMessage() async {
    guard !messageToSend.isEmpty else { return }
    self.isPosting = true
    do {
      let response = try await apiService.postData(with: messageToSend)
      self.receivedMessage = response.response.received // Update received message with the echo
      self.isPosting = false
      self.messageToSend = "" // Clear the message field after successful post
    } catch {
      print("Error posting data: \(error)")
      
      DispatchQueue.main.async {
        self.isPosting = false
      }
    }
  }
}
