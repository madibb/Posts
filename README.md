# Posts challenge

The project was build with XCode 14.3.1. 

The project is modularized and packages use `swift-tools-version 5.7`, and UIKit & SwiftUI.

I hid the project file is under the folder *Core*. 
You only need to open the `Posts.xcworkspace`.

The main package file is under:
```
├── Core
│   ├── CoreApp
│   │   ├── Package.swift
```

The exercise is to create a three-screen app:
1. a login screen
2. a list of posts of the user
3. comments for a post

Write a small Application where a user can login with his UserID and fetch his posts.
Rest-API to use for fetching posts: https://jsonplaceholder.typicode.com

The app randomly can fail the mocked network request with a probability of 25%. (disabled now locally)

The app is scalable and new features can be added inside the *Features* folder:
```
├── Features
│   ├── Info - Just a placeholder with my name
│   ├── Login - around user and login screen
│   └── Posts - the main feature around posts and favorites
```

## External dependencies via SPM:

- Swinject
- Reachability

## Network

The app uses an injected network module which is a simple implementation based on a network service using URLSession.

## UI Components & Theme

- *PillView* - a bubble with text and colors
- *MessageView* - a generic view used to display info

- Colors have default / darkMode versions based on the `UITraitCollection`
- Handled screen rotation

## Unit tests

I mocked dependencies and used them in the unit tests for 2 modules:

*Network Module*:
- network service
- network client

*Posts Module*:
- posts service provider

## I used:

- async-await & Combine
- UIKit & SwiftUI
- MVVM-C
- Dependency injection using Swinject delivered in @Inject property wrappers
- Modularization
- SFSafeSymbols for using SFSymbols for icons
- type-safe translations (similar to SwiftGen)

## Localization

For the sake of example, I added translations for English and German and used in a type-safe manner. Not all strings are translated.
   
## Things to improve
- persist the favorite posts on the device, and show them even if there is no internet connection. (Now ony the favorite `postIds` are stored for the respective `userId`)
- handle network error codes
- add unit tests for the view models
  
   
## Main structure

```
├── Commons
│   ├── Dependencies
│   ├── NetworkModule
│   └── Utils
├── Components
│   ├── Package.swift
│   └── Sources
├── Core
│   ├── CoreApp
│   ├── Posts
│   └── Posts.xcodeproj
├── Data
│   └── Models
├── Features
│   ├── Info
│   ├── Login
│   └── Posts
├── Posts.xcworkspace
```
