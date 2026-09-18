import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authSession: AuthSession
    @AppStorage("avoidCrowds") private var avoidCrowds = UserPreferences.defaults.avoidCrowds
    @AppStorage("avoidNoise") private var avoidNoise = UserPreferences.defaults.avoidNoise
    @AppStorage("preferFastest") private var preferFastest = UserPreferences.defaults.preferFastest
    @AppStorage("preferSimpleRoute") private var preferSimpleRoute = UserPreferences.defaults.preferSimpleRoute
    @AppStorage("comfortPriority") private var comfortPriority = UserPreferences.defaults.comfortPriority
    @AppStorage("walkingPace") private var walkingPaceRawValue = UserPreferences.defaults.walkingPace.rawValue
    @State private var didReset = false
    @State private var showSignOutConfirmation = false

    private var preferences: UserPreferences {
        UserPreferences(
            avoidCrowds: avoidCrowds,
            avoidNoise: avoidNoise,
            preferFastest: preferFastest,
            preferSimpleRoute: preferSimpleRoute,
            comfortPriority: comfortPriority,
            walkingPace: WalkingPace(rawValue: walkingPaceRawValue) ?? .normal
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Settings")
                        .font(.title.bold())
                        .foregroundStyle(QRTheme.slate)

                    Text("Manage your account and tune route suggestions around your comfort needs.")
                        .font(.subheadline)
                        .foregroundStyle(QRTheme.muted)
                }

                AccountCard(
                    name: authSession.currentUserName,
                    email: authSession.currentUserEmail,
                    signOutAction: { showSignOutConfirmation = true }
                )

                SettingsSection(title: "Comfort Profile", systemImage: "leaf.fill") {
                    VStack(spacing: 0) {
                        PreferenceToggleRow(
                            title: "Avoid crowds",
                            subtitle: "Prioritize lower-traffic hallways.",
                            systemImage: "person.3.fill",
                            isOn: $avoidCrowds
                        )

                        Divider().padding(.leading, 52)

                        PreferenceToggleRow(
                            title: "Avoid noise",
                            subtitle: "Prefer quieter paths and calmer areas.",
                            systemImage: "speaker.wave.1.fill",
                            isOn: $avoidNoise
                        )
                    }
                }

                SettingsSection(title: "Route Ranking", systemImage: "arrow.triangle.branch") {
                    VStack(spacing: 16) {
                        PreferenceToggleRow(
                            title: "Prefer fastest",
                            subtitle: "Give travel time more weight when routes are close.",
                            systemImage: "timer",
                            isOn: $preferFastest
                        )

                        Divider().padding(.leading, 52)

                        PreferenceToggleRow(
                            title: "Simple route",
                            subtitle: "Favor fewer turns for easier wayfinding.",
                            systemImage: "arrow.triangle.turn.up.right.circle.fill",
                            isOn: $preferSimpleRoute
                        )

                        Divider()

                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                Label("Comfort priority", systemImage: "slider.horizontal.3")
                                    .font(.headline)
                                    .foregroundStyle(QRTheme.slate)
                                Spacer()
                                Text("\(Int(comfortPriority))/5")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(QRTheme.primary)
                            }

                            Slider(value: $comfortPriority, in: 1...5, step: 1)
                                .tint(QRTheme.primary)

                            Text("Higher priority recommends calmer routes even when they take a little longer.")
                                .font(.caption)
                                .foregroundStyle(QRTheme.muted)
                        }
                    }
                }

                SettingsSection(title: "Walking Pace", systemImage: "figure.walk") {
                    Picker("Walking pace", selection: $walkingPaceRawValue) {
                        ForEach(WalkingPace.allCases) { pace in
                            Text(pace.rawValue).tag(pace.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                PreferenceSummaryCard(preferences: preferences)

                Button {
                    resetPreferences()
                } label: {
                    Label("Reset Preferences", systemImage: "arrow.counterclockwise")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .foregroundStyle(QRTheme.primary)
                        .background(QRTheme.card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(QRTheme.primary.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(20)
        }
        .background(QRTheme.background.ignoresSafeArea())
        .alert("Preferences Reset", isPresented: $didReset) {
            Button("Done") {}
        }
        .confirmationDialog("Sign out of QuietRoute?", isPresented: $showSignOutConfirmation) {
            Button("Sign Out", role: .destructive) {
                authSession.signOut()
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func resetPreferences() {
        avoidCrowds = UserPreferences.defaults.avoidCrowds
        avoidNoise = UserPreferences.defaults.avoidNoise
        preferFastest = UserPreferences.defaults.preferFastest
        preferSimpleRoute = UserPreferences.defaults.preferSimpleRoute
        comfortPriority = UserPreferences.defaults.comfortPriority
        walkingPaceRawValue = UserPreferences.defaults.walkingPace.rawValue
        didReset = true
    }
}

private struct AccountCard: View {
    let name: String
    let email: String
    let signOutAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(QRTheme.primary)

                VStack(alignment: .leading, spacing: 4) {
                    Text(name.isEmpty ? "QuietRoute User" : name)
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)
                    Text(email.isEmpty ? "Signed in" : email)
                        .font(.subheadline)
                        .foregroundStyle(QRTheme.muted)
                }

                Spacer()
            }

            HStack(spacing: 10) {
                AccountMetric(title: "Saved mode", value: "Balanced")
                AccountMetric(title: "Priority", value: "Comfort")
            }

            Button(action: signOutAction) {
                Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .foregroundStyle(.red)
                    .background(Color.red.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .settingsPanel()
    }
}

private struct AccountMetric: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(QRTheme.muted)
            Text(value)
                .font(.caption.weight(.bold))
                .foregroundStyle(QRTheme.slate)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(QRTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct SettingsSection<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(QRTheme.slate)

            content
        }
        .settingsPanel()
    }
}

private struct PreferenceToggleRow: View {
    let title: String
    let subtitle: String
    let systemImage: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(QRTheme.primary)
                .frame(width: 40, height: 40)
                .background(QRTheme.accent.opacity(0.22))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(QRTheme.slate)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(QRTheme.muted)
            }

            Spacer()

            Toggle(title, isOn: $isOn)
                .labelsHidden()
                .tint(QRTheme.primary)
        }
        .padding(.vertical, 4)
    }
}

private struct PreferenceSummaryCard: View {
    let preferences: UserPreferences

    private var recommendation: String {
        if preferences.preferFastest {
            return "Balanced routes will lean faster, while still checking comfort."
        }
        if preferences.avoidCrowds && preferences.avoidNoise {
            return "Calmest routes will be recommended first for busy class transitions."
        }
        if preferences.preferSimpleRoute {
            return "Routes with fewer turns will be favored for easier wayfinding."
        }
        return "Balanced routes will compare comfort and travel time evenly."
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Recommendation Style", systemImage: "sparkles")
                .font(.headline)
                .foregroundStyle(QRTheme.slate)

            Text(recommendation)
                .font(.subheadline)
                .foregroundStyle(QRTheme.muted)
        }
        .settingsPanel()
    }
}

private extension View {
    func settingsPanel() -> some View {
        padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(QRTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthSession())
    }
}
