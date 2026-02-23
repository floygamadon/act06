import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // set counter value
  int _counter = 0;

  // Color changes based on counter value
  Color _statusColor() {
    if (_counter == 0) return Colors.red;
    if (_counter <= 50) return Colors.orange; // yellow/orange/green zone
    if (_counter < 100) return Colors.green;
    return Colors.deepPurple; // LIFTOFF color
  }

  // Ignite (increase the fuel)
  void _ignite() {
    setState(() {
      // increment by 1 (keep within 0..100)
      if (_counter < 100) _counter++;
    });
  }

  // Decrement (decrease fuel safely)
  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  // Reset (abort mission)
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    final Color status = _statusColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: status, // dynamic color changes
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                _counter == 100 ? "LIFTOFF!" : '$_counter',
                style: const TextStyle(fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt().clamp(0, 100);
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),

          const SizedBox(height: 20),

          // Ignite button
          ElevatedButton(
            onPressed: _ignite,
            child: const Text('Ignite'),
          ),
          const SizedBox(height: 10),

          // Decrement Button
          ElevatedButton(
            onPressed: _decrement,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Decrement'),
          ),

          const SizedBox(height: 10),

          // Reset Button
          ElevatedButton(
            onPressed: _reset,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}