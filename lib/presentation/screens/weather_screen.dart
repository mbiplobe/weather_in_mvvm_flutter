import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_in_mvvm_flutter/presentation/viewmodels/weather_viewmodel.dart';
import 'package:weather_in_mvvm_flutter/widget/TextWithIconWidget.dart';
import '../../widget/DailyForecastItem.dart';
import '../../widget/HourlyForecastItem.dart';
import '../../widget/OneDirectionLine.dart';
import '../../widget/SunAnimationWidget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherViewModel>().loadWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (BuildContext context, WeatherViewModel weatherVM, Widget? child) {
        final weather = weatherVM.weather;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: weather == null
                  ? const SizedBox.shrink()
                  : Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    weather.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            leadingWidth: 150,
            actions: const [
              Icon(Icons.settings, color: Colors.white),
              SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            child: weatherVM.isLoading
                ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : weatherVM.error != null
                ? Center(
              child: Text(
                'Error: ${weatherVM.error}',
                style: const TextStyle(color: Colors.white),
              ),
            )
                : weather == null
                ? const Center(child: Text("No data available", style: TextStyle(color: Colors.white)))
                : Center(
                  child: SingleChildScrollView(
                                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Image.network(
                        "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
                      ),
                      Text(
                        '${weatherVM.ConvertTemp(weather.temp, 'F')}',
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${weather.weatherDescription} ${weatherVM.ConvertTemp(weather.tempMin, 'F')}° / ${weatherVM.ConvertTemp(weather.tempMax, 'F')}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 20,),

                      Card(
                        elevation: 5,
                        color: Colors.brown,
                        child: Padding(padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWithIconWidget(text: "${weather.pressure} hPa", source: Image.asset('assets/images/gauge.png', width: 24, height: 24,color: Colors.white,)),
                                TextWithIconWidget(text: "${weather.humidity}%", source: Image.asset('assets/images/humidity_24.png', width: 24, height: 24,color: Colors.white,))
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWithIconWidget(text: weatherVM.ConvertWindSpeed(weather.windSpeed, 'Kilo')!, source: Image.asset('assets/images/windy_24.png', width: 24, height: 24,color: Colors.white,)),
                                TextWithIconWidget(text: weatherVM.convertVisibility(weather.visibility,'Kilo')!, source: Image.asset('assets/images/visibility_24.png', width: 24, height: 24,color: Colors.white,)),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithIconWidget(text: weatherVM.SunriseTime!, source: Image.asset('assets/images/sunrise_24.png', width: 24, height: 24,)),
                                Expanded(
                                    child:  OneDirectionLine()),
                                TextWithIconWidget(text: weatherVM.SunsetTime!, source: Image.asset('assets/images/sunset_24.png', width: 24, height: 24,)),

                              ],
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                        )

                      )

                    ],
                  ),
                                ),
                              ),
                ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
