import 'package:flutter/material.dart';
import '../../data/models/equipo_futbol.dart';
import '../pages/detalle_equipo_page.dart';

class EquipoCard extends StatelessWidget {
  final EquipoFutbol equipo;

  const EquipoCard({super.key, required this.equipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: equipo.escudoUrl.isNotEmpty
                ? Image.network(
                    equipo.escudoUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.sports_soccer, size: 30, color: Colors.green),
                  )
                : const Icon(Icons.sports_soccer, size: 30, color: Colors.green),
          ),
          title: Text(
            equipo.nombre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.emoji_events_outlined, size: 14, color: Colors.green.shade700),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      equipo.liga,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green.shade800),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalleEquipoPage(equipo: equipo),
              ),
            );
          },
        ),
      ),
    );
  }
}