import 'package:flutter/material.dart';
// Imports actualizados con las rutas de tu proyecto
import 'package:flutter_auth_app/screens/pantalla_dashboard.dart'; 
import 'package:flutter_auth_app/screens/task_list_screen.dart';
import 'package:flutter_auth_app/screens/profile_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      appBar: AppBar(
        title: const Text(
          'CALENDARIO',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tarjeta del Calendario Mensual
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Abril 2026',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.blue),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.blue),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                      .map((d) => Text(
                            d,
                            style: const TextStyle(
                                color: Colors.grey, fontWeight: FontWeight.bold),
                          ))
                      .toList(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Color(0xFFF0F0F0)),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Visualización de mes en desarrollo...",
                    style: TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'AGENDA DE HOY',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildEventTile(
                  'Examen Parcial Cálculo',
                  '08:00 AM - Aula 105',
                  Colors.red[50]!,
                  Colors.red[400]!,
                ),
                _buildEventTile(
                  'Entrega Proyecto Flutter',
                  '11:59 PM - Virtual',
                  const Color(0xFFF3E5F5),
                  const Color(0xFF64B5F6), // Azul consistente
                ),
                _buildEventTile(
                  'Reunión Grupo de Física',
                  '04:00 PM - Biblioteca',
                  Colors.blue[50]!,
                  Colors.blue[400]!,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),

      // --- BARRA DE NAVEGACIÓN TOTALMENTE VINCULADA ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, 
        selectedItemColor: const Color(0xFF64B5F6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) return; // Ya estamos en Calendario
          
          Widget nextScreen;
          switch (index) {
            case 0: 
              nextScreen = const PantallaDashboard(); 
              break;
            case 2: 
              nextScreen = const TaskListScreen(); 
              break;
            case 3: 
              nextScreen = const ProfileScreen(); 
              break;
            default: 
              nextScreen = const CalendarScreen();
          }

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => nextScreen,
              transitionDuration: Duration.zero,
            ),
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: 'Tareas'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildEventTile(String title, String detail, Color bgColor, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 45,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: Colors.grey[400]),
        ],
      ),
    );
  }
}