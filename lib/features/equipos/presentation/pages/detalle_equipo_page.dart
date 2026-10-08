import 'package:flutter/material.dart';
import '../../data/models/equipo_futbol.dart';

class DetalleEquipoPage extends StatelessWidget {
  final EquipoFutbol equipo;

  const DetalleEquipoPage({super.key, required this.equipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(equipo.nombre, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Superior con Escudo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: equipo.escudoUrl.isNotEmpty
                        ? Image.network(
                            equipo.escudoUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.sports_soccer, size: 80, color: Colors.green),
                          )
                        : const Icon(Icons.sports_soccer, size: 80, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    equipo.nombre,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  if (equipo.siglas.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Chip(
                        label: Text(
                          equipo.siglas,
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.green.shade50,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Ficha de Datos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Información del Club',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const Divider(height: 24),
                      _buildItemInformacion(Icons.emoji_events, 'Liga Principal', equipo.liga),
                      _buildItemInformacion(Icons.stadium, 'Estadio', equipo.estadio),
                      _buildItemInformacion(Icons.location_city, 'Ciudad / País', equipo.ciudad),
                      _buildItemInformacion(Icons.calendar_today, 'Año de Fundación', equipo.anioFundacion),
                    ],
                  ),
                ),
              ),
            ),
            if (equipo.descripcion.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reseña Histórica',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const Divider(height: 24),
                        Text(
                          equipo.descripcion,
                          style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildItemInformacion(IconData icon, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.green.shade800, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                Text(
                  valor.isNotEmpty ? valor : 'N/A',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}