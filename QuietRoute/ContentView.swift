import SwiftUI

struct ContentView: View {
    @StateObject private var authSession = AuthSession()

    var body: some View {
        Group {
            if authSession.isAuthenticated {
                MainTabView()
            } else {
                AuthView()
            }
        }
        .environmentObject(authSession)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
