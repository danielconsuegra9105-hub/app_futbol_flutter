import 'package:flutter/material.dart';
import '../../data/models/equipo_futbol.dart';
import '../../data/services/api_service.dart';
import '../widgets/equipo_card.dart';

class BuscarEquipoPage extends StatefulWidget {
  const BuscarEquipoPage({super.key});

  @override
  State<BuscarEquipoPage> createState() => _BuscarEquipoPageState();
}

class _BuscarEquipoPageState extends State<BuscarEquipoPage> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  List<EquipoFutbol> _equipos = [];
  bool _isLoading = false;
  String? _errorMessage;

  void _buscar() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _equipos = [];
    });

    try {
      final resultados = await _apiService.buscarEquiposPorNombre(query);
      setState(() {
        _equipos = resultados;
        if (_equipos.isEmpty) {
          _errorMessage = "No se encontraron equipos con ese nombre.";
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
        title: const Row(
          children: [
            Icon(Icons.sports_soccer, color: Colors.white),
            SizedBox(width: 10),
            Text('FutbolDB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        elevation: 4,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ej: Atletico Nacional, Barcelona...',
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_circle_right, color: Colors.green, size: 30),
                    onPressed: _buscar,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: (_) => _buscar(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.green))
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : _equipos.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sports, size: 80, color: Colors.grey.shade400),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Busca un club para explorar sus datos',
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _equipos.length,
                              itemBuilder: (context, index) {
                                return EquipoCard(equipo: _equipos[index]);
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }
}