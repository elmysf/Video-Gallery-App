# Video Gallery App

## Overview

This project is developed using SwiftUI, leveraging the MVVM (Model-View-ViewModel) architecture along with Combine for reactive programming. Local Swift Package Manager (SPM) is utilized for dependency management, ensuring a modular and maintainable codebase.

<img src="https://github.com/elmysf/Video-Gallery-App/blob/main/Demo.gif" width="300" />

## Table of Contents

- [Installation](#installation)
- [Setup Instructions](#setup-instructions)
- [Architecture](#architecture)
- [Assumptions](#assumptions)

## Installation
To try out the Video Gallery app examples:
1. Clone the repo `git clone https://github.com/elmysf/Video-Gallery-App.git`.
2. Open `Video Gallery App.xcodeproj`.
3. Run `Video Gallery App.xcodeproj` - framework is imported as a local SPM package.
4. Try it!

## Architecture

The project follows the MVVM architecture, which separates the user interface from the business logic. Here's a brief breakdown:

- **Model:** Represents the data and business logic. It fetches data from APIs or databases and manages data operations.
  
- **View:** Composed of SwiftUI views that define the user interface. It observes the ViewModel for data updates and user interactions.
  
- **ViewModel:** Acts as a bridge between the Model and the View. It holds the business logic, prepares data for display, and handles user input.
  
- **Combine:** Used for handling asynchronous data streams and updates. It allows for a reactive approach, updating the UI in response to data changes.
  
- **Local SPM (Swift Package Manager):** Manages external dependencies locally, ensuring that the project remains modular and easy to maintain.

## Assumptions

- The project assumes a basic understanding of SwiftUI, Combine, and the MVVM architecture.
- It is assumed that any required API services are available and properly configured in the application.
- Users are expected to have Xcode installed and set up on their machines to build and run the project.

## ScreenShoot

<img src="https://github.com/elmysf/Video-Gallery-App/blob/main/Screenshoot.jpg" width="800" />
<img src="https://github.com/elmysf/Video-Gallery-App/blob/main/Strurctue.jpg" width="800" />
