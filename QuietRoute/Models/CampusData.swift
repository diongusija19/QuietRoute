import Foundation
import CoreLocation

enum CampusData {
    static let quickDestinations = ["Library", "Cafeteria", "Student Center", "Lecture Hall A"]

    static func routes(for destination: String) -> [RouteOption] {
        switch destination {
        case "Cafeteria":
            return cafeteriaRoutes
        case "Student Center":
            return studentCenterRoutes
        case "Lecture Hall A":
            return lectureHallRoutes
        default:
            return libraryRoutes
        }
    }

    private static let libraryRoutes: [RouteOption] = [
        .init(destination: "Library", name: "Central Corridor", minutes: 11, comfortScore: 42, crowd: .high, noise: .high, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7743, longitude: -79.5003),
            .init(latitude: 43.7749, longitude: -79.4996)
        ]),
        .init(destination: "Library", name: "Garden Walk", minutes: 14, comfortScore: 76, crowd: .medium, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7734, longitude: -79.5002),
            .init(latitude: 43.7742, longitude: -79.4996),
            .init(latitude: 43.7749, longitude: -79.4996)
        ]),
        .init(destination: "Library", name: "Library Side Path", minutes: 16, comfortScore: 89, crowd: .low, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7731, longitude: -79.5008),
            .init(latitude: 43.7732, longitude: -79.4998),
            .init(latitude: 43.7740, longitude: -79.4992),
            .init(latitude: 43.7749, longitude: -79.4996)
        ])
    ]

    private static let cafeteriaRoutes: [RouteOption] = [
        .init(destination: "Cafeteria", name: "Atrium Cut", minutes: 8, comfortScore: 40, crowd: .high, noise: .high, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7744, longitude: -79.5007),
            .init(latitude: 43.7748, longitude: -79.5002)
        ]),
        .init(destination: "Cafeteria", name: "Courtyard Route", minutes: 10, comfortScore: 74, crowd: .medium, noise: .medium, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7735, longitude: -79.5005),
            .init(latitude: 43.7740, longitude: -79.5000),
            .init(latitude: 43.7748, longitude: -79.5002)
        ]),
        .init(destination: "Cafeteria", name: "South Greenway", minutes: 13, comfortScore: 88, crowd: .low, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7730, longitude: -79.5006),
            .init(latitude: 43.7733, longitude: -79.4997),
            .init(latitude: 43.7743, longitude: -79.4998),
            .init(latitude: 43.7748, longitude: -79.5002)
        ])
    ]

    private static let studentCenterRoutes: [RouteOption] = [
        .init(destination: "Student Center", name: "Main Hall Route", minutes: 9, comfortScore: 45, crowd: .high, noise: .medium, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7744, longitude: -79.5009),
            .init(latitude: 43.7750, longitude: -79.5008)
        ]),
        .init(destination: "Student Center", name: "Terrace Route", minutes: 12, comfortScore: 77, crowd: .medium, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7736, longitude: -79.5004),
            .init(latitude: 43.7742, longitude: -79.5001),
            .init(latitude: 43.7750, longitude: -79.5008)
        ]),
        .init(destination: "Student Center", name: "Quiet Arc", minutes: 15, comfortScore: 90, crowd: .low, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7731, longitude: -79.5007),
            .init(latitude: 43.7734, longitude: -79.4998),
            .init(latitude: 43.7744, longitude: -79.4999),
            .init(latitude: 43.7750, longitude: -79.5008)
        ])
    ]

    private static let lectureHallRoutes: [RouteOption] = [
        .init(destination: "Lecture Hall A", name: "North Spine", minutes: 10, comfortScore: 43, crowd: .high, noise: .high, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7747, longitude: -79.5009),
            .init(latitude: 43.7753, longitude: -79.5005)
        ]),
        .init(destination: "Lecture Hall A", name: "Garden Connector", minutes: 13, comfortScore: 78, crowd: .medium, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7736, longitude: -79.5004),
            .init(latitude: 43.7745, longitude: -79.5001),
            .init(latitude: 43.7753, longitude: -79.5005)
        ]),
        .init(destination: "Lecture Hall A", name: "Perimeter Path", minutes: 17, comfortScore: 91, crowd: .low, noise: .low, path: [
            .init(latitude: 43.7739, longitude: -79.5011),
            .init(latitude: 43.7729, longitude: -79.5008),
            .init(latitude: 43.7732, longitude: -79.4999),
            .init(latitude: 43.7743, longitude: -79.4997),
            .init(latitude: 43.7753, longitude: -79.5005)
        ])
    ]
}
