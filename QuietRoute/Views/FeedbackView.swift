import SwiftUI

struct FeedbackView: View {
    @State private var selectedRouteName = CampusData.allRoutes.first?.name ?? "Garden Walk"
    @State private var crowdRating = 3
    @State private var noiseRating = 3
    @State private var comfortRating = 4
    @State private var note = ""
    @State private var didSubmit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Feedback")
                    .font(.title.bold())
                    .foregroundStyle(QRTheme.slate)

                Text("Rate a route so future recommendations can be calmer and more accurate.")
                    .font(.subheadline)
                    .foregroundStyle(QRTheme.muted)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Route")
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)

                    Picker("Route", selection: $selectedRouteName) {
                        ForEach(CampusData.allRoutes, id: \.name) { route in
                            Text("\(route.name) to \(route.destination)")
                                .tag(route.name)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(QRTheme.background)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .feedbackPanel()

                RatingSection(title: "Crowd Level", lowLabel: "Quiet", highLabel: "Crowded", rating: $crowdRating)
                RatingSection(title: "Noise Level", lowLabel: "Low", highLabel: "Loud", rating: $noiseRating)
                RatingSection(title: "Comfort", lowLabel: "Stressful", highLabel: "Calm", rating: $comfortRating)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Notes")
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)

                    TextField("Add anything useful about this route", text: $note, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                        .padding(12)
                        .background(QRTheme.background)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .feedbackPanel()

                Button {
                    didSubmit = true
                } label: {
                    Text("Submit Feedback")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .foregroundStyle(.white)
                        .background(QRTheme.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .padding(20)
        }
        .background(QRTheme.background.ignoresSafeArea())
        .alert("Feedback Submitted", isPresented: $didSubmit) {
            Button("Done") {
                resetForm()
            }
        } message: {
            Text("Thanks. QuietRoute can use this kind of feedback to improve comfort scores over time.")
        }
    }

    private func resetForm() {
        crowdRating = 3
        noiseRating = 3
        comfortRating = 4
        note = ""
    }
}

private struct RatingSection: View {
    let title: String
    let lowLabel: String
    let highLabel: String
    @Binding var rating: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(QRTheme.slate)
                Spacer()
                Text("\(rating)/5")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(QRTheme.primary)
            }

            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { value in
                    Button {
                        rating = value
                    } label: {
                        Image(systemName: value <= rating ? "circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(value <= rating ? QRTheme.primary : QRTheme.muted.opacity(0.45))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(title)
            .accessibilityValue("\(rating) out of 5")

            HStack {
                Text(lowLabel)
                Spacer()
                Text(highLabel)
            }
            .font(.caption)
            .foregroundStyle(QRTheme.muted)
        }
        .feedbackPanel()
    }
}

private extension View {
    func feedbackPanel() -> some View {
        padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(QRTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
