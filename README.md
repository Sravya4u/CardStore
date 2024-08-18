
# Card Store

## Overview
The **Card Store** project is an iOS application that displays a collection of credit cards fetched from a remote API. It leverages the power of SwiftUI for the user interface and follows the MVVM (Model-View-ViewModel) architecture pattern. The app also supports bookmarking cards for easy access and includes functionality to handle both real API data and local mock data.

## Screenshots in the flow with App
- Step1:
  User will Click on App - "CardStore". App hits the remote api and fetches the card data.
  
![StoreCardLogo](https://github.com/user-attachments/assets/c78a03fa-d39c-4a08-a924-7d2bb84f11c7)


![Simulator Screen Shot - iPhone 14 Pro - 2024-08-18 at 18 19 57](https://github.com/user-attachments/assets/37e1240a-c482-4561-9f13-4901e862e77a)

-Step2 
User can see the screen loading gracefully as shown below :

![Simulator Screen Shot - iPhone 14 Pro - 2024-08-18 at 18 20 37](https://github.com/user-attachments/assets/37b1ddd6-6ada-4015-afe2-44aabed1ee0a)


-Step3
CardStore App loads home screen with 2 tabs called CardGroups and Bookmarks. CardGroups tab will be selected on load.
All cards are grouped and sorted by card type on loading. Each card type and card count is displayed on the screen

![Simulator Screen Shot - iPhone 14 Pro - 2024-08-18 at 18 16 37](https://github.com/user-attachments/assets/0afff74e-88ce-4c97-9aaf-52b82ab3bd2b)

-Step4  User can click each group and see a list view of all cards of that card type. user and navigate back to cardGroups again to check other cardtypes. 

![Simulator Screen Shot - iPhone 14 Pro - 2024-08-18 at 18 18 20](https://github.com/user-attachments/assets/08ec010a-9124-4256-afd8-4d78caf96a32)

-Step5 User can bookmark the cards from different card groups using bookmark button and cards will be saved in to bookmarks tab.
Bookmark is a toggle and can be removed on click from bookmarks view.

![Simulator Screen Shot - iPhone 14 Pro - 2024-08-18 at 18 18 05](https://github.com/user-attachments/assets/ab61fc7b-ca73-4efc-bb21-8c33e882eba5)

## Architecture Details
The architecture of the CardStore App follows a Model-View-ViewModel (MVVM) design pattern. It consists of the following components:

Model: Represents the data entities and business logic. Includes the Card model object and associated networking services.
View: Displays the user interface elements. Includes views such as CardGroupView , CreditCardListView and BookmarkView.
ViewModel: Acts as an intermediary between the view and model layers. Includes the CardViewModel class responsible for fetching and loading card data on the views.

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
    
### 3. `CreditCardListView`
- **Purpose:** Displays a list of credit cards using SwiftUI.
- **Key Responsibilities:**
  - Displaying the cards fetched by the `CardViewModel`.
  - Handling user interactions such as selecting a card.

### 4. `CreditCardView`
- **Purpose:** Represents the UI for an individual credit card.
- **Key Responsibilities:**
  - Displaying the card details such as card number, type, and expiration date.
  - Supporting the bookmark toggle functionality.

### 5. `Card`
- **Purpose:** Represents the model for a credit card.
- **Key Responsibilities:**
  - Contains properties such as `id`, `creditCardType`, `cardNumber`, `expirationDate`, and `isBookmarked`.
  - Conforms to the `Decodable` protocol for easy decoding from JSON data.

### 6. `BookmarkView`
- **Purpose:** Displays a list of bookmarked cards.
- **Key Responsibilities:**
  - Shows only the cards that have been marked as bookmarked by the user.
  - Allows users to remove cards from bookmarks.

### 7. `CardGroupsView`
- **Purpose:** Groups cards by type and displays them in a categorized list.
- **Key Responsibilities:**
  - Uses the `groupedCards` function from the `CardViewModel` to categorize cards.
  - Displays each group with a header representing the card type.


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


