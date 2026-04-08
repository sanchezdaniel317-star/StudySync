import 'package:flutter/material.dart';
// Asegúrate de que estas rutas coincidan con tu estructura de carpetas
import 'package:flutter_auth_app/screens/pantalla_dashboard.dart'; 
import 'package:flutter_auth_app/screens/calendar_screen.dart';
import 'package:flutter_auth_app/screens/profile_screen.dart'; // <--- Importado

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 24, 20),
              child: Text(
                'LISTA DE TAREAS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildFilterChip('Todos', isSelected: true),
                  _buildFilterChip('Materia'),
                  _buildFilterChip('Prioridad'),
                  _buildFilterChip('Fecha'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  _TaskItem(
                    title: 'Estudiar Matemáticas',
                    subtitle: 'Materia: Matemáticas | Prioridad: Alta',
                    date: '04/04/2026',
                    accentColor: Colors.red,
                  ),
                  _TaskItem(
                    title: 'Hacer ensayo Historia',
                    subtitle: 'Materia: Historia | Prioridad: Media',
                    date: '21/06/2026',
                    accentColor: Colors.orange,
                  ),
                  _TaskItem(
                    title: 'Preparar laboratorio Química',
                    subtitle: 'Materia: Química | Prioridad: Baja',
                    date: '26/06/2026',
                    accentColor: Colors.green,
                  ),
                  _TaskItem(
                    title: 'Leer artículo de Física',
                    subtitle: 'Materia: Física | Prioridad: Media',
                    date: '24/05/2026',
                    accentColor: Colors.blue,
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- BARRA DE NAVEGACIÓN ACTUALIZADA ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, 
        selectedItemColor: const Color(0xFF64B5F6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) return;
          
          Widget nextScreen;
          switch (index) {
            case 0: 
              nextScreen = const PantallaDashboard(); 
              break;
            case 1: 
              nextScreen = const CalendarScreen(); 
              break;
            case 3: 
              nextScreen = const ProfileScreen(); // <--- Ahora conectado
              break;
            default: 
              nextScreen = const TaskListScreen();
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

  static Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (v) {},
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFFF3EBF9),
        checkmarkColor: const Color(0xFF6A4C93),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF6A4C93) : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isSelected ? const Color(0xFF6A4C93) : Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final Color accentColor;

  const _TaskItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withOpacity(0.5), width: 2),
            ),
            child: Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            date.substring(0, 5),
            style: TextStyle(color: Colors.grey[400], fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}