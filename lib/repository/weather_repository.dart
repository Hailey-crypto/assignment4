// lib/weather/repository/weather_repository.dart
import 'package:assignment4/core/weather_service.dart';
import 'package:assignment4/model/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository {
  final WeatherService _service = WeatherService();

  // 위치 권한 요청 + 현재 위치 가져오기
  Future<Position> _getPosition() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) throw Exception("위치 서비스 꺼짐");

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("위치 권한 영구 거부됨");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // 위치 기반 날씨 가져오기
  Future<WeatherModel> getWeather() async {
    final pos = await _getPosition();

    final data = await _service.fetchWeather(
      lat: pos.latitude,
      lon: pos.longitude,
    );

    final current = data["current"] as Map<String, dynamic>;

    return WeatherModel.fromJson(current);
  }
}
