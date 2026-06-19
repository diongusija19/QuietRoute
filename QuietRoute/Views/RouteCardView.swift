import SwiftUI

struct RouteCardView: View {
    let route: RouteOption
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(route.name)
                    .font(.headline)
                    .foregroundStyle(QRTheme.slate)
                Spacer()
                Text("\(route.minutes) min")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(QRTheme.primary)
            }

            Text("Comfort Score \(route.comfortScore)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(QRTheme.primary)

            Text("Crowd: \(route.crowd.rawValue)   Noise: \(route.noise.rawValue)")
                .font(.subheadline)
                .foregroundStyle(QRTheme.muted)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(QRTheme.card)
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(isSelected ? QRTheme.primary : Color.clear, lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)
    }
}
