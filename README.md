
# Card Store

## Overview
The **Card Store** project is an iOS application that displays a collection of credit cards fetched from a remote API. It leverages the power of SwiftUI for the user interface and follows the MVVM (Model-View-ViewModel) architecture pattern. The app also supports bookmarking cards for easy access and includes functionality to handle both real API data and local mock data.

## Screenshots in the flow with App
- Step1: (User will Click on App - "CardStore")

## Architecture Details

### 1. `CardViewModel`
- **Purpose:** Acts as the ViewModel in the MVVM architecture, managing the state of the cards and bookmarks.
- **Key Responsibilities:**
  - Fetching cards from the remote API or loading mock data.
  - Handling network and decoding errors.
  - Managing bookmarks.
  - Grouping cards based on their type.

### 2. `NetworkManager`
- **Purpose:** Handles network operations and acts as a service provider for fetching cards from a remote API or loading mock data.
- **Key Responsibilities:**
  - Fetching card data from a specified URL.
  - Handling various network errors like invalid URL, decoding failures, etc.
  - Exposing functions to load mock cards for testing purposes.


## Error Handling
The project includes comprehensive error handling for network, URL, and decoding errors. These errors are propagated to the `CardViewModel`, which updates the UI with appropriate error messages.

## Testing
The project includes unit tests for:
- Validating the success and failure scenarios of the `fetchCards` function.
- Handling of various error conditions in both the `CardViewModel` and `NetworkManager`.

## Getting Started

### Technologies and Frameworks
- Swift
- SwiftUI
- URLSession
- Combine

### Installation
1. Clone the repository:
    \`\`\`sh
    git clone https://github.com/yourusername/cardstore.git
    \`\`\`
2. Open the project in Xcode:
    \`\`\`sh
    open CardStore.xcodeproj
    \`\`\`
3. Build and run the project.

### Usage
- The app will fetch a list of credit cards from the remote API.
- Users can toggle bookmarks on individual cards.
- Users can view grouped cards by their type.


