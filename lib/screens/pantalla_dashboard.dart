import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PantallaDashboard extends StatelessWidget {
  
  const PantallaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50], // Fondo beige muy claro
        useMaterial3: true,
      ),
      home: const StudentDashboardPage(),
    );
  }
}

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de estado simulada
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // No se muestra AppBar real
        child: Container(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Simulación de Barra de Estado Superior (Hora, Iconos)
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '10:09 AM',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.signal_cellular_alt, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            
            // Sección de Encabezado
            const HeaderSection(),

            // Sección de Próximas Clases
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'TU DÍA',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
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
                          color: Colors.blue[200]!,
                          iconData: Icons.book_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClassCard(
                          subject: 'Cálculo II',
                          time: '11:30 AM - 1:00 PM',
                          location: 'Aula 105',
                          teacher: 'Prof. Ruiz',
                          color: Colors.orange[400]!,
                          iconData: Icons.calculate_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sección de Trabajos a Entregar
            const AssignmentsSection(),

            // Sección de Tu Semana
            const WeeklyCalendar(),
            
            // Espacio final para que el FAB no cubra contenido
            const SizedBox(height: 80),
          ],
        ),
      ),
      
      // Botón de Acción Flotante (FAB)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      
      // Navegación Inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // 'Inicio' seleccionado
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Tareas'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Widget de Encabezado
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Row(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!, width: 2),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey, // Reemplazar con imagen real
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), 
              child: Text("M", style: TextStyle(color: Colors.white)), // Marcador de posición
            ),
          ),
          const SizedBox(width: 16),
          // Saludo y Fecha
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      '¡Hola, Daniel!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.school, color: Colors.amber, size: 24),
                  ],
                ),
                Text(
                  _formatDate(DateTime.now()),
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizable para Tarjeta de Clase
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gráfico circular interno con icono
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: color, size: 28),
              ),
              const SizedBox(height: 16),
              Text(
                subject,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                time,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(location, style: const TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(teacher, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
        ),
        // Libros superpuestos a la derecha
        Positioned(
          right: -10,
          top: 20,
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.collections_bookmark_outlined, color: Colors.grey[400], size: 30),
          ),
        ),
      ],
    );
  }
}

// Sección de Trabajos a Entregar
class AssignmentsSection extends StatelessWidget {
  const AssignmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'TRABAJOS A ENTREGAR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'ENTREGAS PENDING',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tarjeta de Trabajos
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildAssignmentTile(
                    'Ensayo Literario', 'Literatura', '17 Mayo, 23:59', true, Icons.check_circle_outline, Colors.green),
                const Divider(),
                _buildAssignmentTile(
                    'Proyecto Final', 'Física', '20 Mayo, 18:00', false, Icons.star_border, Colors.amber),
                const Divider(),
                _buildAssignmentTile(
                    'Informe Lab', 'Química', '22 Mayo, 12:00', false, Icons.access_time, Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para cada fila de trabajo
  Widget _buildAssignmentTile(String title, String subject, String deadline, bool priority, IconData statusIcon, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subject, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 4),
              Text(deadline, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              if (priority)
                Row(
                  children: const [
                    Icon(Icons.whatshot, color: Colors.red, size: 14),
                    SizedBox(width: 4),
                    Text('Alta Prioridad', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
            ],
          ),
          Icon(statusIcon, color: statusColor, size: 30),
        ],
      ),
    );
  }
}

// Widget personalizado para el Calendario Semanal
class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TU SEMANA',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildDayColumn('Lunes', [const CalendarBlock(text: 'Clases', color: Colors.blue)]),
                _buildDayColumn('Martes', [
                  const CalendarBlock(text: 'Clases', color: Colors.orange),
                  const CalendarBlock(text: 'Moderna', color: Colors.red),
                  const CalendarBlock(text: 'Aula', color: Colors.green),
                ]),
                _buildDayColumn('Miércoles', [
                  const CalendarBlock(text: 'Clases', color: Colors.orange),
                  const CalendarBlock(text: 'Clases', color: Colors.blue),
                ]),
                _buildDayColumn('Jueves', [
                  const CalendarBlock(text: 'Clases', color: Colors.green),
                  const CalendarBlock(text: 'Química', color: Colors.purple),
                ]),
                _buildDayColumn('Viernes', [
                  const CalendarBlock(text: 'Viernes', color: Colors.purple),
                  const CalendarBlock(text: 'Class', color: Colors.blue),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para cada columna de día
  Widget _buildDayColumn(String dayName, List<Widget> blocks) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                dayName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Divider(color: Colors.grey[200]!, height: 1),
            // Bloques de contenido con margen y altura para simular cuadrícula
            Container(
              height: 150, // Altura fija para todos los días
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: blocks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
String _formatDate(DateTime date) {
  const meses = [
    '', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
  ];
  return '${date.day} de ${meses[date.month]}';
}
// Widget auxiliar para los bloques de color del calendario
class CalendarBlock extends StatelessWidget {
  final String text;
  final Color color;

  const CalendarBlock({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded( // Para ocupar el espacio disponible uniformemente
      child: Container(
        margin: const EdgeInsets.all(3),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle( fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
