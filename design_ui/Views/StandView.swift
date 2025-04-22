import SwiftUI

struct StandView: View {
  @StateObject var viewModel = StandViewModel()
  
  var body: some View {
    NavigationView {
      Text("Hello, World!")
    }
    .navigationTitle("API Interaction")
    .onAppear {
    }
  }
}
