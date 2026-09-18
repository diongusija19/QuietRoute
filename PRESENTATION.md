# QuietRoute Presentation Notes

## One-Sentence Pitch

QuietRoute is an iOS campus navigation app that helps students choose routes based on comfort, crowd level, noise level, and time instead of only showing the fastest path.

## Problem

Most navigation apps optimize for speed. On a campus, the fastest path is not always the best path for students who want to avoid crowded hallways, noisy areas, or stressful transitions between classes.

## Solution

QuietRoute compares multiple route options for the same destination and ranks them by speed, comfort score, crowd level, and noise level. Students can choose Fastest, Balanced, or Calmest depending on what they need in the moment.

## Main Features To Demo

- Authentication with sign in, account creation, demo account, persistent session, and sign out.
- Home screen with quick destination choices.
- Route options with Fastest, Balanced, and Calmest modes.
- Route cards showing ETA, comfort score, crowd level, and noise level.
- Active route map using MapKit with start and destination markers.
- Calm spots directory for quiet study, outdoor reset, and rest areas.
- Feedback form for crowd, noise, comfort, and notes.
- Account-aware Settings that persist preferences and influence balanced route recommendations.

## Demo Script

1. "I built QuietRoute for students who want a calmer way to move around campus."
2. Sign in with the demo account or tap Use Demo Account.
3. On Home, choose Library and tap Find Route.
4. Show the three ranking modes: Fastest, Balanced, Calmest.
5. Select a calmer route and tap Start Selected Route.
6. Point out the MapKit route line, start marker, destination marker, ETA, and comfort score.
7. Open Calm Spots and filter the list.
8. Open Feedback, change a rating, add a short note, and submit.
9. Open Settings and explain the account card, sign out option, and personalized route preferences.

## Technical Highlights

- Built with Swift and SwiftUI.
- Uses `NavigationStack`, `TabView`, `ScrollView`, `LazyVGrid`, `Picker`, `Slider`, alerts, and reusable card views.
- Uses MapKit for route preview rendering.
- Uses an observable view model for route ranking state.
- Uses an observable authentication session and `UserDefaults` for prototype account/session storage.
- Uses `AppStorage` so preferences persist between launches.
- Organizes the app into Models, Views, ViewModels, and a small design system.

## Demo Account

```text
Email: student@quietroute.ca
Password: quiet123
```

## Future Improvements

- Connect route data to a real campus map service.
- Use live hallway crowd reports from student feedback.
- Add accessibility-specific route tags such as elevators, ramps, and low-stair paths.
- Add saved favorite destinations and recent routes.
- Add more detailed indoor wayfinding for building floors and rooms.
