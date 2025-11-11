import 'package:assignment4/model/weather_model.dart';
import 'package:assignment4/repository/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_info_view_model.g.dart';

@riverpod
class WeatherInfoViewModel extends _$WeatherInfoViewModel {
  final WeatherRepository _repo = WeatherRepository();

  @override
  Future<WeatherModel> build() async {
    return await _repo.getWeather();
  }
}
