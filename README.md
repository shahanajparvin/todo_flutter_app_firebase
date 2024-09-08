# Flutter ToDo App

## Overview
This Flutter-based ToDo app allows users to manage tasks both online and offline, with seamless synchronization to Firebase. It is designed using clean architecture and incorporates app flavors for different environments (e.g., development, staging, production). The project uses `flutter_bloc` for state management, supports localization in English and Arabic, and implements complex animations while optimizing performance.

## App Screenshots

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732300.png" alt="Screenshot 1" width="250" style="margin: 20px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732307.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732313.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732323.png" alt="Screenshot 1" width="250" style="margin: 40px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732330.png" alt="Screenshot 3" width="250" style="margin: 40px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732345.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732347.png" alt="Screenshot 1" width="250" style="margin: 20px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732351.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725732372.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734589.png" alt="Screenshot 1" width="250" style="margin: 40px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734593.png" alt="Screenshot 3" width="250" style="margin: 40px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734624.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734727.png" alt="Screenshot 1" width="250" style="margin: 20px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734734.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734740.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>

<p align="center">
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734773.png" alt="Screenshot 1" width="250" style="margin: 40px;"/>
 <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734788.png" alt="Screenshot 3" width="250" style="margin: 40px;"/>
  <img src="https://github.com/shahanajparvin/todo_flutter_app_firebase/blob/master/screenshots/Screenshot_1725734897.png" alt="Screenshot 3" width="250" style="margin: 20px;"/>
</p>


## Project Architecture
The project follows the Clean Architecture pattern, ensuring separation of concerns and scalability. Flavors are integrated to handle environment-specific configurations.

### The layers include:
- **Presentation Layer**: UI, BLoC (Business Logic Component), and localization.
- **Domain Layer**: Entities, repositories, and use cases.
- **Data Layer**: Firebase, local database (Floor), and background syncing.

## Features

### Core Features:
- Task management: Add, update, delete, and view tasks.
- Offline-first with background sync every 6 hours using `flutter_workmanager`.
- Automatic sync when internet connectivity changes from offline to online.
- Smooth, complex animations.
- Localization in English and Arabic.
- Username setup and update.

### Flavors:
- **Development**: For internal testing, connected to a test Firebase environment.
- **Staging**: For pre-production testing, mimicking production settings but connected to a different Firebase instance.
- **Production**: For the final app release, connected to the production Firebase environment.

## State Management
State management is handled using the `flutter_bloc` package, ensuring a clear separation between UI and business logic.

**Key BLoC instances**:
- **TaskBloc**: Handles task addition, updates, deletions, and syncing.
- **LanguageBloc**: Manages dynamic language switching between English and Arabic.
- **UsernameBloc**: Manages the user's name displayed on the home page.

## Database
- **Local Database (Floor)**: Tasks are saved locally for offline access.
- **Remote Database (Firebase Firestore)**: Tasks are synchronized with Firebase.

The app ensures that the local and remote databases stay in sync using background syncing and reactive updates on network changes.

## Offline Sync
The app uses the `flutter_workmanager` package to sync tasks with Firebase every 6 hours. If the network status changes from offline to online, tasks are immediately synchronized.

**Sync Conditions**:
- Background sync runs every 6 hours.
- Internet connection change triggers immediate sync.

## Localization
The app supports both English and Arabic using the `intl` package. Language switching is dynamic, managed by `LanguageBloc`.

- The app displays all labels, buttons, and text in the selected language, except for user input like task titles and descriptions.
- Localization applies to the entire UI, including dates and times.

## User Interface
The app’s UI focuses on delivering a smooth user experience with animations, while optimizing for memory efficiency.

**Key UI elements**:
- **Splash Screen**: Username input and language selection.
- **Task Screens**: Add, update, delete, and view tasks.
- **Animations**: Transitions and user interactions are animated, ensuring performance remains smooth.

## App Flavors
Flavors are used to configure the app for different environments: development, staging, and production. This ensures environment-specific configurations such as Firebase connections, API endpoints, and other settings.

### Flavor Configuration
Each flavor has its own Firebase configuration and environment settings:


- **Staging**: Used for pre-release testing, mimicking production conditions.
- **Production**: The live version of the app for end-users.


## Localization
The app supports both English and Arabic using the `intl` package. Language switching is dynamic, managed by `LanguageBloc`.

- The app displays all labels, buttons, and text in the selected language, except for user input like task titles and descriptions.
- Localization applies to the entire UI, including dates and times.

## To Generate Translations
To generate translations for your app, run the following command:

```
flutter gen-l10n
```

## Running the App

### To Run Staging:
```bash
--flavor staging
```


### To Run Live:
```bash
--flavor live
```

### To Build Staging Apk:
```bash
flutter build apk --debug --target lib/main_staging.dart 
```


### To Build Release Apk:
```bash
flutter build apk --release --target lib/main_live.dart
```


