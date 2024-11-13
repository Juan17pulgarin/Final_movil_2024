import 'package:flutter/material.dart';

class WeatherForm extends StatefulWidget {
  final Function(double, double) onSubmitted;

  const WeatherForm({super.key, required this.onSubmitted});

  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final latitude = double.parse(_latitudeController.text);
      final longitude = double.parse(_longitudeController.text);
      widget.onSubmitted(latitude, longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitud',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[200],
            ),
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese una latitud';
              }
              try {
                double.parse(value);
              } catch (_) {
                return 'Ingrese un valor numérico válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _longitudeController,
            decoration: InputDecoration(
              labelText: 'Longitud',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[200],
            ),
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese una longitud';
              }
              try {
                double.parse(value);
              } catch (_) {
                return 'Ingrese un valor numérico válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 4,
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Obtener Temperatura'),
          ),
        ],
      ),
    );
  }
}
