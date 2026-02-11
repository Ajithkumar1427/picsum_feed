Picsum Infinite Feed App

Overview

This Flutter application displays an infinite scrolling feed of high-quality images using the Lorem Picsum API.

The project focuses on:

    Efficient pagination
    Smooth scrolling performance
    Image caching
    Clean state management using BLoC
    Polished UI/UX implementation

Features

    Infinite scrolling feed (15 items per page)
    Pull-to-refresh functionality
    Cached network images (prevents flicker and re-download)
    Shimmer loading placeholder while images load
    Detail screen with:
        Hero animation transition
        Pinch-to-zoom support
    Proper error handling with Retry mechanism

Architecture & State Management

This project uses the BLoC (flutter_bloc) pattern for state management.

Why BLoC?
    Clear separation of UI and business logic
    Efficient handling of pagination
    Proper management of loading, success, and error states
    Scalable and maintainable architecture


Project Structure

lib/
 ├── config/           → API configuration
 ├── features/feed/
 │    ├── bloc/        → State management (BLoC)
 │    ├── model/       → Data models
 │    ├── view/        → Screens
 │    └── widget/      → Reusable widgets


API Used

Base Endpoint: https://picsum.photos/v2/list

Pagination parameters:
?page=1
?limit=15

Example:
https://picsum.photos/v2/list?page=1&limit=15


▶️ How to Run the Project

Clone the repository:
git clone <your-repository-link>

Navigate to the project directory:
cd picsum_feed_app

Install dependencies:
flutter pub get

Run the application:
flutter run


Performance Considerations
Pagination prevents loading large data at once
Scroll threshold prevents duplicate API calls
Cached images reduce unnecessary network usage
Fixed image dimensions ensure smooth scrolling
Shimmer improves loading experience



👨‍💻 Author
Ajith Kumar