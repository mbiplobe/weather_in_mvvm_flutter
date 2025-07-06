# Weather Forcaster
### Designed a real-time weather monitoring application using Flutter and OpenWeather API.

A simple weather App created using [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/) and [MVVM] (https://medium.com/@ignatovich.dm/mvvm-architecture-in-react-a-beginners-guide-with-examples-bde116f1347c) and using API from [OpenWeatherMap](https://openweathermap.org/)</br></br>

<p align="center">
<img src="https://github.com/mbiplobe/weather_in_mvvm_flutter/assets/images/screen1.png" width="20%"></img>
<img src="https://github.com/mbiplobe/weather_in_mvvm_flutter/assets/images/screen2.png" width="20%"></img>
</p>

## API Docs   
> [!IMPORTANT] 
> This project uses **_version 2.5_** of the OpenWeatherMap API</br>
> **API used in this project**:</br>
> - [Current Weather API Docs](https://openweathermap.org/current#one)</br>
> - [One Call API Docs](https://openweathermap.org/api/one-call-api#data)</br>
> - [Geocoding API Docs](https://openweathermap.org/api/geocoding-api)</br>


## 🚀 Features
- 🌍 Automatically detects and acquires the user's current location  
- 🌦️ Displays real-time weather data based on the user's current location  

## 🛠️ Technologies Used
- Flutter with Provider architecture
- Geolocator for location services
- OpenWeatherMap API for weather data
- MVVM architecture

## How to Run
1. Create an account at [OpenWeatherMap](https://openweathermap.org/).
2. Then get your API key from https://home.openweathermap.org/api_keys.
   >Sometimes after getting your OpenWeatherMap API key it won't work right away </br>
   >To test if your API key is working or not copy and paste the following link to your browser</br>
   >https://api.openweathermap.org/data/2.5/weather?lat=53.4794892&lon=-2.2451148&units=metric&appid=YOUR_API_KEY</br>
   >Then replace `YOUR_API_KEY` with your own API key from OpenWeatherMap
3. Clone the repo
   ```sh
   git clone https://github.com/mbiplobe/weather_in_mvvm_flutter.git
   ```
4. Install all the packages by typing
   ```sh
   flutter pub get
   ```
5. Navigate to **lib/provider/weatherProvider.dart** and paste your API key to the apiKey variable
   ```dart
   String apiKey = 'Paste Your API Key Here';
   ```
6. Run the App

## Contact
- [Github]([https://github.com/ArizArmeidi/](https://github.com/mbiplobe/mbiplobe) | [Twitter](https://x.com/mbiplobe) | [LinkedIn](https://www.linkedin.com/in/mbiplobe/)

## License
Distributed under the MIT License. See `LICENSE` for more information.

