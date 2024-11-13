import 'package:flutter/material.dart';
import 'package:final_2024/weather_form.dart';
import 'package:final_2024/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const WeatherScreen({super.key, required this.onToggleTheme});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _temperature;
  bool _isLoading = false;

  void _fetchTemperature(double latitude, double longitude) async {
    setState(() {
      _isLoading = true;
    });

    final temperature =
        await WeatherService.getTemperature(latitude, longitude);

    setState(() {
      _temperature = temperature;
      _isLoading = false;
    });

    if (temperature != "Error") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Conexión exitosa con la API.'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[400],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error al conectar con la API.'),
          backgroundColor: Colors.red[400],
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Temperatura'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.brightness_2),
            onPressed: widget.onToggleTheme,
          ),
        ],
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.blueGrey[700],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Consulta de Temperatura',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.blueGrey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WeatherForm(onSubmitted: _fetchTemperature),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: isDarkMode ? Colors.blue[300] : Colors.blueGrey,
                    ),
                  )
                : Card(
                    color: isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _temperature != null
                            ? 'Temperatura Actual: $_temperature°C'
                            : 'Ingrese coordenadas para consultar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode ? Colors.white : Colors.blueGrey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            const Spacer(),
            Text(
              'Desarrollado por Jean Blanco y Juan Pablo Pulgarín',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[400] : Colors.blueGrey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
