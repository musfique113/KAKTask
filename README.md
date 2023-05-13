# KAK Task

KAK Task is a simple Flutter todo app that helps users keep track of their daily tasks. This app is built using Flutter framework and utilizes REST API from https://api.nstack.in/ to store and retrieve user's tasks.

## Features

- Add new tasks
- Edit existing tasks
- Delete tasks
- View all tasks

## Requirements

- http: ^0.13.6 package
- Internet connection to communicate with API

## Setup

1. Clone the repository to your local machine using `git clone <repository-url>`
2. Run `flutter pub get` to install dependencies
3. Create an account on https://api.nstack.in/ and obtain an API key
4. Update the `apiKey` variable in `lib/utils/constants.dart` with your API key
5. Update the `apiBaseUrl` variable in `lib/utils/constants.dart` with the API URL https://api.nstack.in/#/Todo/
6. Run the app on a device or emulator using `flutter run`

## Screenshots

![KAK Task Screenshot 1](https://user-images.githubusercontent.com/12345678/12345678/12345678.png)

![KAK Task Screenshot 2](https://user-images.githubusercontent.com/12345678/12345678/12345678.png)

