import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';
import '../../models/appointment.dart';
import '../home/home_screen.dart';

class ReceiptScreen extends StatefulWidget {
  final Appointment appointment;

  const ReceiptScreen({super.key, required this.appointment});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.elasticOut));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<double>(begin: 60, end: 0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appt = widget.appointment;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Success checkmark
                ScaleTransition(
                  scale: _scaleAnim,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primary, AppTheme.primaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: AppTheme.primary.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 8))
                      ],
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 54),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: _slideAnim,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, _slideAnim.value),
                    child: child,
                  ),
                  child: Column(
                    children: [
                      Text('Booking Confirmed!',
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textDark)),
                      Text('Your appointment has been successfully booked',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.textMedium)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Ticket Card ─────────────────────────────────────
                _TicketCard(appointment: appt),
                const SizedBox(height: 24),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download_rounded,
                            color: AppTheme.primary, size: 18),
                        label: Text('Download',
                            style: GoogleFonts.poppins(
                                color: AppTheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: AppTheme.primary, width: 1.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                            (_) => false,
                          );
                        },
                        icon: const Icon(Icons.home_rounded,
                            color: Colors.white, size: 18),
                        label: Text('Home',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Ticket Card Widget ──────────────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  final Appointment appointment;

  const _TicketCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        children: [
          // Ticket header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryDark, AppTheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.medical_services_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text('DocBook',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('CONFIRMED',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        appointment.doctorImageUrl,
                        width: 68,
                        height: 68,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 68,
                          height: 68,
                          color: Colors.white24,
                          child: const Icon(Icons.person_rounded,
                              color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appointment.doctorName,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),
                          Text(appointment.doctorSpecialty,
                              style: GoogleFonts.poppins(
                                  color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(appointment.hospital,
                              style: GoogleFonts.poppins(
                                  color: Colors.white60, fontSize: 11),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dashed separator
          _DashedDivider(),

          // Ticket body
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              children: [
                // Booking number
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: AppTheme.primary.withValues(alpha: 0.1), width: 1),
                  ),
                  child: Column(
                    children: [
                      Text('Booking Number',
                          style: GoogleFonts.poppins(
                              color: AppTheme.textMedium, fontSize: 11)),
                      const SizedBox(height: 4),
                      Text(appointment.bookingNumber,
                          style: GoogleFonts.poppins(
                              color: AppTheme.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Details grid
                _receiptRow('Patient Name', appointment.patientName),
                _receiptRow("Father's Name", appointment.fatherName),
                _receiptRow('CNIC', appointment.cnic),
                _receiptRow(
                    'Date',
                    DateFormat('EEEE, dd MMMM yyyy')
                        .format(appointment.appointmentDate)),
                _receiptRow('Time', appointment.timeSlot),
                _receiptRow('Consultation Fee',
                    'PKR ${appointment.fee.toInt()}',
                    highlight: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _receiptRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  color: AppTheme.textMedium, fontSize: 12.5)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  color: highlight ? AppTheme.primary : AppTheme.textDark,
                  fontSize: 13,
                  fontWeight:
                      highlight ? FontWeight.w700 : FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 30),
      painter: _DashedDividerPainter(),
    );
  }
}

class _DashedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()..color = const Color(0xFFEEF2F5);
    canvas.drawCircle(Offset(-15, size.height / 2), 22, circlePaint);
    canvas.drawCircle(
        Offset(size.width + 15, size.height / 2), 22, circlePaint);

    final dashPaint = Paint()
      ..color = const Color(0xFFDDE3EB)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 5.0;
    double startX = 10;
    while (startX < size.width - 10) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(math.min(startX + dashWidth, size.width - 10), size.height / 2),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
