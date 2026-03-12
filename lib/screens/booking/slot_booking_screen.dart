import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../models/doctor.dart';
import 'patient_form_screen.dart';

class SlotBookingScreen extends StatefulWidget {
  final Doctor doctor;

  const SlotBookingScreen({super.key, required this.doctor});

  @override
  State<SlotBookingScreen> createState() => _SlotBookingScreenState();
}

class _SlotBookingScreenState extends State<SlotBookingScreen> {
  late List<DateTime> _nextDays;
  int _selectedDateIndex = 0;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime(2026, 3, 11);
    _nextDays = List.generate(7, (i) => now.add(Duration(days: i + 1)));
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
                boxShadow: AppTheme.softShadow),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textDark, size: 18),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Slot',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppTheme.textDark)),
            Text(widget.doctor.name,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: AppTheme.textMedium)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Doctor mini card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(18),
                boxShadow: AppTheme.softShadow,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      widget.doctor.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.person_rounded,
                            color: AppTheme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.doctor.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppTheme.textDark)),
                        Text(widget.doctor.specialty,
                            style: GoogleFonts.poppins(
                                color: AppTheme.primary, fontSize: 12)),
                        Text(widget.doctor.hospital,
                            style: GoogleFonts.poppins(
                                color: AppTheme.textMedium, fontSize: 11),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Text('PKR ${widget.doctor.fee.toInt()}',
                      style: GoogleFonts.poppins(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Date selection
            Text('Select Date',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _nextDays.length,
                itemBuilder: (context, i) {
                  final date = _nextDays[i];
                  final isSelected = i == _selectedDateIndex;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedDateIndex = i;
                      _selectedTime = null;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 10),
                      width: 64,
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppTheme.primary : AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                 color: AppTheme.primary.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 5))
                              ]
                            : AppTheme.softShadow,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd').format(date),
                            style: GoogleFonts.poppins(
                                color: isSelected ? Colors.white : AppTheme.primary.withValues(alpha: 0.1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            DateFormat('EEE').format(date),
                            style: GoogleFonts.poppins(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.85)
                                    : AppTheme.textMedium,
                                fontSize: 11),
                          ),
                          Text(
                            DateFormat('MMM').format(date),
                            style: GoogleFonts.poppins(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.75)
                                    : AppTheme.textLight,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Time slot selection
            Text('Available Time Slots',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.doctor.availableTimes.map((time) {
                final isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = time),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: const Color(0xFFDDE3EB), width: 1),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                  color: AppTheme.primary.withValues(alpha: 0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4))
                            ]
                          : AppTheme.softShadow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textMedium,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.textDark,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedTime == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PatientFormScreen(
                              doctor: widget.doctor,
                              appointmentDate: _nextDays[_selectedDateIndex],
                              timeSlot: _selectedTime!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  disabledBackgroundColor: AppTheme.textLight,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  elevation: 0,
                ),
                child: Text(
                  _selectedTime == null
                      ? 'Select a Time Slot'
                      : 'Continue to Book',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
