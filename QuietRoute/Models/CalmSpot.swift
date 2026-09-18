import Foundation

enum CalmSpotType: String, CaseIterable, Identifiable {
    case all = "All"
    case study = "Study"
    case outdoor = "Outdoor"
    case rest = "Rest"

    var id: String { rawValue }
}

struct CalmSpot: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let type: CalmSpotType
    let distance: String
    let comfortScore: Int
    let crowd: CrowdLevel
    let noise: NoiseLevel
    let bestFor: String
    let notes: String

    static let samples: [CalmSpot] = [
        .init(
            name: "Library Quiet Corner",
            location: "Library, Floor 2",
            type: .study,
            distance: "4 min away",
            comfortScore: 92,
            crowd: .low,
            noise: .low,
            bestFor: "Focused study",
            notes: "Small seating area away from the main staircase with low foot traffic and soft lighting."
        ),
        .init(
            name: "Garden Bench",
            location: "East Garden Path",
            type: .outdoor,
            distance: "6 min away",
            comfortScore: 88,
            crowd: .low,
            noise: .low,
            bestFor: "Fresh air break",
            notes: "Outdoor seating near the garden path, useful between classes when indoor spaces feel busy."
        ),
        .init(
            name: "Student Center Lounge",
            location: "Student Center, Back Hall",
            type: .rest,
            distance: "3 min away",
            comfortScore: 74,
            crowd: .medium,
            noise: .medium,
            bestFor: "Short reset",
            notes: "A convenient place to sit briefly. It can get busier around lunch, but is calmer than the main atrium."
        ),
        .init(
            name: "North Study Nook",
            location: "Academic Wing B",
            type: .study,
            distance: "8 min away",
            comfortScore: 86,
            crowd: .low,
            noise: .low,
            bestFor: "Reading",
            notes: "A quieter hallway nook with charging outlets and fewer interruptions during class blocks."
        )
    ]
}
