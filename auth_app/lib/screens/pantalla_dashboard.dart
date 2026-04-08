import 'package:flutter/material.dart';
// Imports actualizados con las rutas de tu proyecto
import 'package:flutter_auth_app/screens/calendar_screen.dart';
import 'package:flutter_auth_app/screens/task_list_screen.dart';
import 'package:flutter_auth_app/screens/profile_screen.dart';

class PantallaDashboard extends StatelessWidget {
  const PantallaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.grey[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderSection(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TU DÍA',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ClassCard(
                            subject: 'Historia Moderna',
                            time: '9:00 - 11:00 AM',
                            location: 'Aula 302',
                            teacher: 'Prof. Gómez',
                            color: Colors.blue[100]!,
                            iconData: Icons.book_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClassCard(
                            subject: 'Cálculo II',
                            time: '11:30 AM - 1:00 PM',
                            location: 'Aula 105',
                            teacher: 'Prof. Ruiz',
                            color: Colors.orange[100]!,
                            iconData: Icons.calculate_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const AssignmentsSection(),
              const WeeklyCalendar(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, 
        selectedItemColor: const Color(0xFF64B5F6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) return; // Ya estamos en Inicio
          
          Widget nextScreen;
          switch (index) {
            case 1: 
              nextScreen = const CalendarScreen(); 
              break;
            case 2: 
              nextScreen = const TaskListScreen(); 
              break;
            case 3: 
              nextScreen = const ProfileScreen(); 
              break;
            default: 
              nextScreen = const PantallaDashboard();
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
}

// --- SECCIÓN DE ENCABEZADO ---
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF64B5F6),
            child: Text("F", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Hola, Fausto! 👋',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  _formatDate(DateTime.now()),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- TARJETA DE CLASE (Mantenida igual) ---
class ClassCard extends StatelessWidget {
  final String subject;
  final String time;
  final String location;
  final String teacher;
  final Color color;
  final IconData iconData;

  const ClassCard({
    super.key,
    required this.subject,
    required this.time,
    required this.location,
    required this.teacher,
    required this.color,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, color: Colors.black54),
          const SizedBox(height: 12),
          Text(subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 8),
          Text(location, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// --- SECCIÓN DE TAREAS (Mantenida igual) ---
class AssignmentsSection extends StatelessWidget {
  const AssignmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TAREAS PENDIENTES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.assignment_turned_in, color: Colors.green),
                  title: Text('Ensayo Literario'),
                  subtitle: Text('Hoy - 23:59'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  title: Text('Proyecto Física'),
                  subtitle: Text('Mañana'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// --- CALENDARIO SEMANAL (Mantenida igual) ---
class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TU SEMANA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['L', 'M', 'M', 'J', 'V'].map((dia) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dia == 'M' ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(dia, style: TextStyle(color: dia == 'M' ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// --- FUNCIÓN DE FECHA ---
String _formatDate(DateTime date) {
  const meses = [
    '', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
  ];
  return '${date.day} de ${meses[date.month]}';
}