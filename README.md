# Sky Sense App - Hydrated Bloc

The Sky Sense App is a Flutter application that provides weather information based on the city name. It utilizes the Bloc pattern to manage the state and the Hydrated Bloc library to persist the state of its Bloc, enabling the app to seamlessly restore previous data and provide a seamless user experience even after the app is restarted or reopened. This README file will guide you through the installation and usage of the app.

## Implementation

Excited to explore how the Sky Sense App utilizes the power of the Bloc pattern and the Hydrated Bloc library for efficient state management? 
Delve into the comprehensive guide on medium, where we unravel the intricacies of our implementation in detail!

Ready to dive in? Follow the link below:

[Explore Now](https://medium.com/@dtejaswini.06/hydrated-bloc-in-flutter-simplifying-state-management-258542723a6c)

## Features

The Sky Sense App offers the following weather information for a given city:

- Temperature in Celsius and Fahrenheit.
- Wind speed in kilometers per hour.
- Cloud cover percentage.
- Precipitation amount in millimeters.
- Humidity percentage.
- UV Index.
- Pressure in millibars.

## Installation

To install and run the Sky Sense App, follow these steps:

- Clone the repository to your local machine:
```
git clone https://github.com/your-username/sky-sense-app.git
```
- Change into the project directory:
```
cd sky-sense-app
```
- Install the required dependencies using Flutter:
```
flutter pub get
```
- Connect a physical device or start an emulator.
- Run the app:
```
flutter run
```

## Usage

- Launch the Sky Sense App on your device.
- Enter the name of a city in the provided input field.
- Perform the "Search" to retrieve the weather information for the specified city.
- The weather information will be displayed on the screen, including temperature, wind speed, cloud cover, precipitation, humidity, UV index, and pressure.
- To search for the weather of another city, repeat steps 2 to 4.

## Acknowledgments

The Sky Sense App was created with the help of the following open-source libraries and APIs:

Flutter: https://flutter.dev/

Bloc: https://pub.dev/packages/bloc

Hydrated Bloc: https://pub.dev/packages/hydrated_bloc

Dotenv: https://pub.dev/packages/flutter_dotenv
