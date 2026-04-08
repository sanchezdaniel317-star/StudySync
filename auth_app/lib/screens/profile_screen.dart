import 'package:flutter/material.dart';
import 'pantalla_dashboard.dart';
import 'calendar_screen.dart';
import 'task_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FB), // Fondo consistente con los demás
      body: Column(
        children: [
          const SizedBox(height: 80),

          // Foto de perfil con borde sutil
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xFF64B5F6), // Azul del Dashboard
                child: Text(
                  "F",
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Fausto Student',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const Text(
            'Ingeniería de Sistemas',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),

          const SizedBox(height: 35),

          // Stats en tarjetas modernas
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('4.5', 'Promedio'),
                _buildVerticalDivider(),
                _buildStat('12', 'Tareas OK'),
                _buildVerticalDivider(),
                _buildStat('85%', 'Asistencia'),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Opciones de Menú
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuOption(Icons.person_outline, 'Datos Personales'),
                  _buildMenuOption(Icons.notifications_none, 'Notificaciones'),
                  _buildMenuOption(Icons.palette_outlined, 'Apariencia'),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Divider(color: Color(0xFFEEEEEE)),
                  ),
                  _buildMenuOption(Icons.logout, 'Cerrar Sesión', color: Colors.redAccent),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- BARRA DE NAVEGACIÓN (Índice 3 para Perfil) ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, 
        selectedItemColor: const Color(0xFF64B5F6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3) return;
          
          Widget nextScreen;
          switch (index) {
            case 0: nextScreen = const PantallaDashboard(); break;
            case 1: nextScreen = const CalendarScreen(); break;
            case 2: nextScreen = const TaskListScreen(); break;
            default: nextScreen = const ProfileScreen();
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

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF64B5F6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildMenuOption(IconData icon, String title, {Color color = Colors.black87}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color == Colors.redAccent ? Colors.red[50] : const Color(0xFFF0F7FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
      onTap: () {},
    );
  }
}