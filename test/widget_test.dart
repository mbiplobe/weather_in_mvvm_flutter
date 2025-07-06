import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:weather_in_mvvm_flutter/data/datasources/remote_weather_datasource.dart';
import 'package:weather_in_mvvm_flutter/data/repositories_impl/weather_repositories_Imp.dart';
import 'package:weather_in_mvvm_flutter/domain/repositories/weather_repositories.dart';
import 'package:weather_in_mvvm_flutter/domain/usecase/get_weather_usercases.dart';
import 'package:weather_in_mvvm_flutter/main.dart';
import 'package:weather_in_mvvm_flutter/presentation/screens/weather_screen.dart';
import 'package:weather_in_mvvm_flutter/presentation/viewmodels/LocationViewModel.dart';
import 'package:weather_in_mvvm_flutter/presentation/viewmodels/weather_viewmodel.dart';

void main() {
  testWidgets('WeatherScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocationViewModel()),
          Provider<Dio>(create: (_) => Dio()),
          Provider<RemoteWeatherDataSource>(
            create: (ctx) => RemoteWeatherDataSource(ctx.read()),
          ),
          Provider<WeatherRepositories>(
            create: (ctx) => WeatherRepositoryImp(remoteWeatherDataSource: ctx.read()),
          ),
          Provider<WeatherUsecases>(
            create: (ctx) => WeatherUsecases(weatherRepositories: ctx.read()),
          ),
          ChangeNotifierProxyProvider<LocationViewModel, WeatherViewModel>(
            create: (context) =>
                WeatherViewModel(context.read<WeatherUsecases>(), context.read<LocationViewModel>()),
            update: (context, locVM, _) =>
                WeatherViewModel(context.read<WeatherUsecases>(), locVM),
          ),
        ],
        child: const WeatherScreen(),
      ),
    );

    // You can write tests to verify widgets inside WeatherScreen
    expect(find.byType(WeatherScreen), findsOneWidget);

    // Example: check if a widget with text "Loading" or "Weather" shows up
    expect(find.text('Loading...'), findsOneWidget);
  });
}
