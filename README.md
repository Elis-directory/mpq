**Note: This app is not complete and therefore still in Progress of bieng built**

# MPQ App

This SwiftUI-based app manages a queue of items with various properties such as title, description, urgency, and duration.

## Features
- **QueuedItem Struct**: Represents an element in the queue with properties for title, description, urgency, duration, and presentation.
- **Display Functionality**: Utilizes the `display()` function in `QueuedItem` to render items in the UI. Tapping expands and shows detailed information.
- **Color Customization**: Allows users to select colors for urgency levels using hexadecimal values.
- **Dynamic UI**: Adjusts dynamically to user interactions, enabling addition of new items and displaying up to 12 items.

## Code Structure
- `ContentView.swift`: Contains the main SwiftUI structure and user interface logic.
- Extension on `Color`: Adds functionality to initialize colors using hex values.
- `StrokeText` struct: Provides outlined text views.
- `QueuedItem` struct: Represents items in the queue, offering methods for display and property management.
- UI elements: Various SwiftUI views and components for user interaction and display.
- Color palette: Defines colors for different urgency levels and backgrounds.
- Screen dimensions and state variables: Used for UI rendering and logic.

## How to Use
1. **Adding Items**: Click the "+" button to add new items to the queue, specifying title, description, duration, and urgency.
2. **Customizing Urgency**: Choose the urgency level by tapping on the corresponding color.
3. **Viewing Items**: Tap on a queued item to view its details.
4. **Display Limit**: The app displays up to 12 items in the queue.

## Notes
- The app supports customization of queue items based on urgency and duration.
- Modifications and enhancements can be made as needed to extend its functionality or UI.
## Preview

<img width="1436" alt="t1" src="https://github.com/Elis-directory/mpq/assets/150942395/a9d47477-0e43-4921-90e3-972715e6f596">
<br>
<br>
<img width="1433" alt="t2" src="https://github.com/Elis-directory/mpq/assets/150942395/6e05d6b5-d691-46a4-bbc1-134382d9dbd3">



