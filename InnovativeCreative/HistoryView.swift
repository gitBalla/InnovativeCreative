import SwiftUI

struct HistoryView: View {
    @StateObject private var userModel = FetchUserData()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Date: \(userModel.user.dailyData.last?.date ?? "Error")")
                    Text("Points: \(userModel.user.dailyData.last?.totalPoints ?? 0)")
                }
            }
            .navigationTitle("History")
        }
        .task {
              await userModel.fetchData()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
