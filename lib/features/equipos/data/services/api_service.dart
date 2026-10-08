import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../models/equipo_futbol.dart';

class ApiService {
  Future<List<EquipoFutbol>> buscarEquiposPorNombre(String nombre) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.searchTeamEndpoint}$nombre'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['teams'] == null) {
          return [];
        }

        final List<dynamic> equiposJson = data['teams'];
        return equiposJson.map((json) => EquipoFutbol.fromJson(json)).toList();
      } else {
        throw Exception('Error de servidor: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }
}