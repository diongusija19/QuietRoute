import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authSession: AuthSession
    @State private var mode: AuthMode = .signIn
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    VStack(alignment: .leading, spacing: 10) {
                        Image(systemName: "location.north.line.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(QRTheme.primary)

                        Text("QuietRoute")
                            .font(.largeTitle.bold())
                            .foregroundStyle(QRTheme.slate)

                        Text("Sign in to save route preferences, submit feedback, and personalize calm campus navigation.")
                            .font(.subheadline)
                            .foregroundStyle(QRTheme.muted)
                    }
                    .padding(.top, 28)

                    Picker("Authentication mode", selection: $mode) {
                        ForEach(AuthMode.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)

                    VStack(spacing: 14) {
                        if mode == .createAccount {
                            AuthField(
                                title: "Name",
                                systemImage: "person.fill",
                                text: $name,
                                keyboardType: .default,
                                contentType: .name
                            )
                        }

                        AuthField(
                            title: "Email",
                            systemImage: "envelope.fill",
                            text: $email,
                            keyboardType: .emailAddress,
                            contentType: .emailAddress
                        )

                        SecureAuthField(
                            title: "Password",
                            systemImage: "lock.fill",
                            text: $password,
                            contentType: mode == .signIn ? .password : .newPassword
                        )

                        if mode == .createAccount {
                            SecureAuthField(
                                title: "Confirm password",
                                systemImage: "checkmark.shield.fill",
                                text: $confirmPassword,
                                contentType: .newPassword
                            )
                        }

                        if let message = authSession.authMessage {
                            Label(message, systemImage: "exclamationmark.circle.fill")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Button {
                            submit()
                        } label: {
                            Text(mode.primaryActionTitle)
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 54)
                                .foregroundStyle(.white)
                                .background(QRTheme.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }

                        Button {
                            authSession.useDemoAccount()
                        } label: {
                            Label("Use Demo Account", systemImage: "person.crop.circle.badge.checkmark")
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 52)
                                .foregroundStyle(QRTheme.primary)
                                .background(QRTheme.card)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .stroke(QRTheme.primary.opacity(0.25), lineWidth: 1)
                                )
                        }
                    }
                    .padding(16)
                    .background(QRTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)

                }
                .padding(20)
            }
            .background(QRTheme.background.ignoresSafeArea())
        }
    }

    private func submit() {
        switch mode {
        case .signIn:
            authSession.signIn(email: email, password: password)
        case .createAccount:
            authSession.createAccount(
                name: name,
                email: email,
                password: password,
                confirmPassword: confirmPassword
            )
        }
    }
}

private enum AuthMode: String, CaseIterable, Identifiable {
    case signIn = "Sign In"
    case createAccount = "Create Account"

    var id: String { rawValue }

    var primaryActionTitle: String {
        switch self {
        case .signIn:
            return "Sign In"
        case .createAccount:
            return "Create Account"
        }
    }
}

private struct AuthField: View {
    let title: String
    let systemImage: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let contentType: UITextContentType

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(QRTheme.primary)
                .frame(width: 22)
            TextField(title, text: $text)
                .textInputAutocapitalization(.never)
                .keyboardType(keyboardType)
                .textContentType(contentType)
        }
        .padding(14)
        .background(QRTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct SecureAuthField: View {
    let title: String
    let systemImage: String
    @Binding var text: String
    let contentType: UITextContentType

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(QRTheme.primary)
                .frame(width: 22)
            SecureField(title, text: $text)
                .textContentType(contentType)
        }
        .padding(14)
        .background(QRTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthSession())
    }
}
