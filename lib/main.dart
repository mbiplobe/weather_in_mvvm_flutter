import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_in_mvvm_flutter/data/repositories_impl/weather_repositories_Imp.dart';
import 'package:weather_in_mvvm_flutter/domain/repositories/weather_repositories.dart';
import 'package:weather_in_mvvm_flutter/domain/usecase/get_weather_usercases.dart';
import 'package:weather_in_mvvm_flutter/presentation/screens/weather_screen.dart';
import 'package:weather_in_mvvm_flutter/presentation/viewmodels/LocationViewModel.dart';
import 'package:weather_in_mvvm_flutter/presentation/viewmodels/weather_viewmodel.dart';

import 'data/datasources/remote_weather_datasource.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        Provider<Dio>(create: (_) => Dio()),
        Provider<RemoteWeatherDataSource>(
          create: (ctx) => RemoteWeatherDataSource(ctx.read<Dio>()),
        ),
        Provider<WeatherRepositories>(
          create: (ctx) =>
              WeatherRepositoryImp(remoteWeatherDataSource: ctx.read()),
        ),
        Provider<WeatherUsecases>(
          create: (ctx) => WeatherUsecases(weatherRepositories: ctx.read()),
        ),
        ChangeNotifierProxyProvider<LocationViewModel, WeatherViewModel>(
          create: (context) => WeatherViewModel(
            context.read<WeatherUsecases>(),
            context.read<LocationViewModel>(),
          ),
          update: (context, locVM, previous) =>
              previous!..updateLocationViewModel(locVM),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.brown,
          textTheme: const TextTheme(
            headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        home: const WeatherScreen(),
      )
    ),
  );
}
