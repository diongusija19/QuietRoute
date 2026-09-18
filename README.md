# QuietRoute

QuietRoute is an iOS capstone project built with SwiftUI. It helps students choose campus routes based on comfort, not only speed, by comparing crowd level, noise level, travel time, and comfort score.

## Features

- Authentication screen with sign in, create account, demo account, and sign out
- Home screen with quick campus destinations
- Route options for Fastest, Balanced, and Calmest choices
- Comfort score, crowd level, noise level, and ETA for each route
- Selectable route cards
- MapKit route preview with start and destination markers
- Calm spots directory with filters and detail pages
- Feedback form for route comfort, crowd, noise, and notes
- Account-aware settings with persistent preferences that influence balanced route ranking
- Calm, accessible visual style inspired by the capstone proposal

## Tech Stack

- Swift
- SwiftUI
- MapKit
- Xcode
- XcodeGen

## Run The App

Open `QuietRoute.xcodeproj` in Xcode, select an iPhone simulator, and run the app.

## Presentation Demo Flow

1. Start on Authentication and sign in with the demo account.
2. On Home, explain the problem: campus navigation should consider comfort, not only speed.
3. Select a destination such as Library, then tap Find Route.
4. Switch between Fastest, Balanced, and Calmest to show different recommendation priorities.
5. Select a calmer route and tap Start Selected Route to show the MapKit route preview.
6. Open Calm Spots and show filters for study, outdoor, and rest spaces.
7. Open Feedback and submit a sample rating to show how the app can improve recommendations.
8. Open Settings, show the account card, change comfort preferences, then return to Routes to explain personalization.

Demo account:

```text
student@quietroute.ca
quiet123
```

## Build Check

Verified with:

```bash
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild -project QuietRoute.xcodeproj -scheme QuietRoute -destination 'generic/platform=iOS Simulator' -derivedDataPath DerivedData build
```
