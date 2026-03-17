import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/soft_card.dart';
import '../../data/mock_data.dart';
import 'package:intl/intl.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Map<String, String> appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailScreen> createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  bool _isProcessing = false;

  void _completeAppointment() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment marked as Completed')),
      );
      MockData.addConfirmed({
        ...widget.appointment,
        'date': DateFormat('d MMM yyyy').format(DateTime.now()),
      });
      Navigator.pop(context, 'Completed');
    }
  }

  void _cancelAppointment() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Cancel Appointment', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: AppTheme.textDark)),
        content: Text('Are you sure you want to cancel this appointment? The patient will be notified.',
          style: GoogleFonts.poppins(color: AppTheme.textMedium)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No', style: GoogleFonts.poppins(color: AppTheme.textMedium)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: Text('Yes, Cancel', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isProcessing = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        MockData.addCancelled({
          ...widget.appointment,
          'date': DateFormat('d MMM yyyy').format(DateTime.now()),
          'reason': 'Cancelled by doctor',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment has been Cancelled')),
        );
        Navigator.pop(context, 'Cancelled');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppTheme.softShadow,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textDark, size: 18),
          ),
        ),
        title: Text('Patient Details',
            style: GoogleFonts.poppins(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Header Card
            SoftCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded, 
                      size: 40, color: AppTheme.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.appointment['patientName']!,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark)),
                        Text('Booked via App',
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: AppTheme.textMedium)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Appointment Information',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),
            
            _buildDetailSection([
              _detailItem(Icons.access_time_rounded, 'Time Slot', widget.appointment['timeSlot']!),
              _detailItem(Icons.calendar_today_rounded, 'Date', 'Tuesday, 17 March 2026'),
            ]),

            const SizedBox(height: 24),
            Text('Patient Identification',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),

            _buildDetailSection([
              _detailItem(Icons.badge_outlined, 'Father\'s Name', widget.appointment['fatherName']!),
              _detailItem(Icons.credit_card_outlined, 'CNIC Number', '42101-4455882-3'),
              _detailItem(Icons.phone_outlined, 'Phone Number', '+92 334 1122334'),
            ]),

            const SizedBox(height: 24),
            Text('Payment Summary',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),

            _buildDetailSection([
              _detailItem(Icons.payments_outlined, 'Appointment Fee', 'Rs. 1,500'),
              _detailItem(Icons.check_circle_outline_rounded, 'Payment Status', 'Paid (Online)'),
            ]),

            const SizedBox(height: 40),

            if (_isProcessing)
              const Center(child: CircularProgressIndicator(color: AppTheme.primary))
            else
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _cancelAppointment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: AppTheme.error, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          elevation: 0,
                        ),
                        child: Text('Cancel',
                            style: GoogleFonts.poppins(
                                color: AppTheme.error, fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _completeAppointment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.success,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          elevation: 0,
                        ),
                        child: Text('Complete',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(List<Widget> items) {
    return SoftCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(children: items),
    );
  }

  Widget _detailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppTheme.primary),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(fontSize: 11, color: AppTheme.textLight)),
              Text(value, 
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
            ],
          ),
        ],
      ),
    );
  }
}
