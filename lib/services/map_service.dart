import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:medi_query/model/hospital_model.dart';
final mapApiProvider = Provider<MapApi>((ref) => MapApi());

class MapApi {
  Future<String> getLocation(double latitude, double longitude) async {
    String addressString = '';
    try {
      String apiKey = 'pk.b14dade08dd88dd219fe1653cf88459c';
      String endpoint =
          'https://us1.locationiq.com/v1/reverse.php?key=$apiKey&lat=$latitude&lon=$longitude&format=json';
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        String street = jsonData['address']['road'] ?? '';
        String city = jsonData['address']['city'] ?? '';
        String state = jsonData['address']['state'] ?? '';

        addressString = '$street $city, $state';
      }
    } catch (e) {
      addressString = 'Unknown';
      return addressString;
    }
    return addressString;
  }

   Future<List<HospitalModel>> findNearestHospital(
      double latitude, double longitude, ) async {
    List<HospitalModel> banks = [];
    try {
      String apiKey = 'pk.b14dade08dd88dd219fe1653cf88459c';
      String endpoint =
          'https://us1.locationiq.com/v1/nearby.php?key=$apiKey&lat=$latitude&lon=$longitude&tag=hospital&radius=5000&format=json';
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Map<String, dynamic>> bankDataList =
            (jsonData as List).cast<Map<String, dynamic>>();
        banks = bankDataList
            .map((bankData) => HospitalModel(
                name: bankData['name'] ?? '',
                distance: bankData['distance']?.toDouble() ?? 0.0,
                address: bankData['address'] != null
                    ? bankData['address']['road'] ?? ''
                    : '',
                city: bankData['address'] != null
                    ? bankData['address']['city'] ?? ''
                    : '',
                //imageUrl: getBankImage(bankData['name'], imageUrls)
                ))
            .toList();
      }
    } catch (e) {
      print('Failed to fetch nearest hospitals. Exception: $e');
    }
    return banks;
  }

}
