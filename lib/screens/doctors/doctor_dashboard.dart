import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/soft_card.dart';
import '../auth/login_screen.dart';
import 'appointment_detail_screen.dart';
import 'doctor_history_screen.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // Mock data for today's appointments in state so we can 'remove' them
  final List<Map<String, String>> _appointments = [
    {
      'patientName': 'Zaid Ahmed',
      'fatherName': 'Muhammad Ahmed',
      'timeSlot': '10:00 AM - 10:30 AM',
    },
    {
      'patientName': 'Sara Khan',
      'fatherName': 'Abdul Khan',
      'timeSlot': '11:00 AM - 11:30 AM',
    },
    {
      'patientName': 'Umer Farooq',
      'fatherName': 'Farooq Sheikh',
      'timeSlot': '12:30 PM - 01:00 PM',
    },
    {
      'patientName': 'Hina Mani',
      'fatherName': 'Mani J.',
      'timeSlot': '02:00 PM - 02:30 PM',
    },
    {
      'patientName': 'Ali Raza',
      'fatherName': 'Raza Hussain',
      'timeSlot': '03:30 PM - 04:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String todayDate = DateFormat('EEEE, d MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Schedule',
                style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            Text(todayDate,
                style: GoogleFonts.poppins(
                    color: AppTheme.textMedium, fontSize: 13)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DoctorHistoryScreen()),
              );
            },
            icon: const Icon(Icons.history_rounded, color: AppTheme.primary),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded, color: AppTheme.error),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _appointments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy_rounded,
                      size: 80, color: AppTheme.textLight.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text('No appointments for today',
                      style: GoogleFonts.poppins(
                          color: AppTheme.textMedium, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final appt = _appointments[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SoftCard(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AppointmentDetailScreen(appointment: appt),
                        ),
                      );
                      
                      if (result != null && mounted) {
                        setState(() {
                          _appointments.removeAt(index);
                        });
                      }
                    },
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        // Left strip indicator
                        Container(
                          width: 4,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appt['patientName']!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.textDark)),
                              const SizedBox(height: 2),
                              Text('Father\'s Name: ${appt['fatherName']}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: AppTheme.textMedium)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_rounded,
                                      size: 14, color: AppTheme.primary),
                                  const SizedBox(width: 6),
                                  Text(appt['timeSlot']!,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.primary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: AppTheme.primary, size: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
