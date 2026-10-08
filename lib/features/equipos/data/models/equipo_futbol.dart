class EquipoFutbol {
  final String id;
  final String nombre;
  final String nombreAlternativo;
  final String siglas;
  final String anioFundacion;
  final String liga;
  final String estadio;
  final String ciudad;
  final String escudoUrl;
  final String descripcion;

  EquipoFutbol({
    required this.id,
    required this.nombre,
    required this.nombreAlternativo,
    required this.siglas,
    required this.anioFundacion,
    required this.liga,
    required this.estadio,
    required this.ciudad,
    required this.escudoUrl,
    required this.descripcion,
  });

  factory EquipoFutbol.fromJson(Map<String, dynamic> json) {
    // Transformación para omitir restricciones de CORS en Flutter Web
    String rawBadge = json['strBadge'] ?? '';
    String processedBadge = rawBadge;
    if (rawBadge.isNotEmpty) {
      processedBadge = 'https://corsproxy.io/?' + Uri.encodeComponent(rawBadge);
    }

    return EquipoFutbol(
      id: json['idTeam'] ?? '',
      nombre: json['strTeam'] ?? '',
      nombreAlternativo: json['strTeamAlternate'] ?? '',
      siglas: json['strTeamShort'] ?? '',
      anioFundacion: json['intFormedYear'] ?? '',
      liga: json['strLeague'] ?? '',
      estadio: json['strStadium'] ?? '',
      ciudad: json['strLocation'] ?? '',
      escudoUrl: processedBadge,
      descripcion: json['strDescriptionEN'] ?? json['strDescriptionES'] ?? '',
    );
  }
}