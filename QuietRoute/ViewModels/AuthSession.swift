import Foundation

final class AuthSession: ObservableObject {
    @Published private(set) var isAuthenticated: Bool
    @Published private(set) var currentUserName: String
    @Published private(set) var currentUserEmail: String
    @Published var authMessage: String?

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.isAuthenticated = defaults.bool(forKey: AuthKey.isAuthenticated)
        self.currentUserName = defaults.string(forKey: AuthKey.currentUserName) ?? ""
        self.currentUserEmail = defaults.string(forKey: AuthKey.currentUserEmail) ?? ""
    }

    func signIn(email: String, password: String) {
        let normalizedEmail = email.normalizedEmail
        guard normalizedEmail.isValidEmail else {
            authMessage = "Enter a valid email address."
            return
        }

        guard password.count >= 6 else {
            authMessage = "Password must be at least 6 characters."
            return
        }

        if normalizedEmail == "student@quietroute.ca" && password == "quiet123" {
            completeSignIn(name: "QuietRoute Student", email: normalizedEmail)
            return
        }

        let savedPassword = defaults.string(forKey: AuthKey.passwordPrefix + normalizedEmail)
        guard savedPassword == password else {
            authMessage = "No matching account found. Try the demo account or create one."
            return
        }

        let savedName = defaults.string(forKey: AuthKey.namePrefix + normalizedEmail) ?? "QuietRoute User"
        completeSignIn(name: savedName, email: normalizedEmail)
    }

    func createAccount(name: String, email: String, password: String, confirmPassword: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEmail = email.normalizedEmail

        guard trimmedName.count >= 2 else {
            authMessage = "Enter your name."
            return
        }

        guard normalizedEmail.isValidEmail else {
            authMessage = "Enter a valid email address."
            return
        }

        guard password.count >= 6 else {
            authMessage = "Password must be at least 6 characters."
            return
        }

        guard password == confirmPassword else {
            authMessage = "Passwords do not match."
            return
        }

        defaults.set(trimmedName, forKey: AuthKey.namePrefix + normalizedEmail)
        defaults.set(password, forKey: AuthKey.passwordPrefix + normalizedEmail)
        completeSignIn(name: trimmedName, email: normalizedEmail)
    }

    func useDemoAccount() {
        completeSignIn(name: "QuietRoute Student", email: "student@quietroute.ca")
    }

    func signOut() {
        defaults.set(false, forKey: AuthKey.isAuthenticated)
        defaults.removeObject(forKey: AuthKey.currentUserName)
        defaults.removeObject(forKey: AuthKey.currentUserEmail)
        currentUserName = ""
        currentUserEmail = ""
        isAuthenticated = false
    }

    private func completeSignIn(name: String, email: String) {
        defaults.set(true, forKey: AuthKey.isAuthenticated)
        defaults.set(name, forKey: AuthKey.currentUserName)
        defaults.set(email, forKey: AuthKey.currentUserEmail)
        currentUserName = name
        currentUserEmail = email
        authMessage = nil
        isAuthenticated = true
    }
}

private enum AuthKey {
    static let isAuthenticated = "auth.isAuthenticated"
    static let currentUserName = "auth.currentUserName"
    static let currentUserEmail = "auth.currentUserEmail"
    static let namePrefix = "auth.user.name."
    static let passwordPrefix = "auth.user.password."
}

private extension String {
    var normalizedEmail: String {
        trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    var isValidEmail: Bool {
        contains("@") && contains(".") && count >= 6
    }
}
