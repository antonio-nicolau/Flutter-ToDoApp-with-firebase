# Flutter Todo app with Firebase and Riverpod

A Flutter TODO App to show how to work with Rivepord, query Firebase firestore documents, authenticate users with Firebase Auth, manage routers with auto_router, implement dark/light mode

Features:
- Login/SignUp
- Create tasks
- Dark/Light mode
- Internalization (english/portuguese)
- Social Signup (google, facebook and apple) - TO BE IMPLEMENTED
- Social Login (google, facebook and apple) - TO BE IMPLEMENTED


Features:
- Authenticate users with Firebase auth
- Query firestore documents, update and delete
- Manage state with Riverpod
- Manage routers with autoRouter

## Getting Started

To get start with this project you'll need to first of all clone it locally 😜

After that you'll need to run `flutter pub get` to get the dependencies used in this project

Since I am using Firebase, you `must`create a firebase project and enable `Firestore Database` & `Firebase Auth` in the Firebase console.
You can follow this [Firebase CLI Guide](https://firebase.flutter.dev/docs/cli) to create a new project using Firebase CLI. 

After configure your Firebase project by running `flutterfire configure` a new file `firebase_options.dart` is going to be created. Also `google-services.json` & `GoogleService-info.plist` will be created and BUMM you are ready to run the project 💣💥💥 

### Dependencies

- cloud_firestore: ^4.5.0
- firebase_core: ^2.9.0
- flutter_localizations:
    sdk: flutter
- flutter_riverpod: ^2.3.2
- riverpod_annotation: ^2.0.2
- firebase_auth: ^4.4.0
- auto_route: ^6.0.1
- intl: ^0.18.0
- json_annotation: ^4.8.0
- shared_preferences: ^2.0.20

Please notice that we also have `build_runner: ^2.4.1` as dev_dependencies

You'll see below app running in two different languages (english and portuguese)


English

https://user-images.githubusercontent.com/67912928/229255835-785fc6bb-6f27-4280-953a-49ee90dfeea0.mov


Portuguese


https://user-images.githubusercontent.com/67912928/229256014-1022cc85-a849-4fd8-ab90-1dffd9387065.mov




