import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/soft_card.dart';
import '../../data/mock_data.dart';

class DoctorHistoryScreen extends StatefulWidget {
  const DoctorHistoryScreen({super.key});

  @override
  State<DoctorHistoryScreen> createState() => _DoctorHistoryScreenState();
}

class _DoctorHistoryScreenState extends State<DoctorHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppTheme.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Appointment History',
            style: GoogleFonts.poppins(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textMedium,
          indicatorColor: AppTheme.primary,
          indicatorWeight: 3,
          labelStyle:
              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Confirmed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList(MockData.confirmedAppointments, isCancelled: false),
          _buildAppointmentList(MockData.cancelledAppointments, isCancelled: true),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(List<Map<String, String>> appointments,
      {required bool isCancelled}) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded,
                size: 60, color: AppTheme.textLight.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text('No records found',
                style: GoogleFonts.poppins(
                    color: AppTheme.textMedium, fontSize: 14)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appt = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SoftCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appt['patientName']!,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: (isCancelled ? AppTheme.error : AppTheme.primary)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isCancelled ? 'Cancelled' : 'Completed',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isCancelled ? AppTheme.error : AppTheme.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Father\'s Name: ${appt['fatherName']}',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppTheme.textMedium)),
                const Divider(height: 24, color: Color(0xFFDDE3EB)),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 14, color: AppTheme.textLight),
                    const SizedBox(width: 6),
                    Text(appt['date']!,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textDark)),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_rounded,
                        size: 14, color: AppTheme.textLight),
                    const SizedBox(width: 6),
                    Text(appt['timeSlot']!,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textDark)),
                  ],
                ),
                if (isCancelled && appt['reason'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Reason: ${appt['reason']}',
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppTheme.error,
                            fontStyle: FontStyle.italic)),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
