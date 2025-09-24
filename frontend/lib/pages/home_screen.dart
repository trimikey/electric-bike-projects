import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> modules = const [
    "Dealer",
    "Vehicle Model",
    "Vehicle Inventory",
    "Stock Allocation",
    "Customer",
    "User",
    "Appointment",
    "Quotes",
    "Order",
    "Payments",
    "Order Items",
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb || constraints.maxWidth > 600) {
          // Web/Desktop UI
          return _buildWebUI();
        } else {
          // Mobile UI
          return _buildMobileUI();
        }
      },
    );
  }

  /// Mobile UI → List dạng Card
  Widget _buildMobileUI() {
    return Scaffold(
      appBar: AppBar(title: const Text("EV Marketplace")),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(modules[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: Navigate đến từng trang chi tiết
              },
            ),
          );
        },
      ),
    );
  }

  /// Web/Desktop UI → Sidebar + Content
  Widget _buildWebUI() {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: Colors.blueGrey.shade900,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(
                    "EV Marketplace",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                ...modules.map((m) => ListTile(
                      title: Text(m, style: const TextStyle(color: Colors.white)),
                      onTap: () {
                        // TODO: Điều hướng đến trang m
                      },
                    )),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Center(
              child: Text(
                "Chào mừng bạn đến EV Marketplace Dashboard",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
