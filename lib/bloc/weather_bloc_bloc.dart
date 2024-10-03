import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      try {
        final String API = dotenv.env['APIKEY'] ?? '';
        emit(WeatherBlocLoading());

        WeatherFactory wf = WeatherFactory(API, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        log('yha taok');
        log(weather.toString());
        log('yha taok2');
        emit(WeatherBlocSuccess(weather: weather));
      } catch (err) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
