import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../theme/app_theme.dart';
import '../../models/doctor.dart';
import '../../models/appointment.dart';
import 'receipt_screen.dart';

class PatientFormScreen extends StatefulWidget {
  final Doctor doctor;
  final DateTime appointmentDate;
  final String timeSlot;

  const PatientFormScreen({
    super.key,
    required this.doctor,
    required this.appointmentDate,
    required this.timeSlot,
  });

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _cnicController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _fatherNameController.dispose();
    _cnicController.dispose();
    super.dispose();
  }

  void _bookNow() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      final bookingNumber =
          'DOC-${const Uuid().v4().substring(0, 8).toUpperCase()}';
      final appointment = Appointment(
        bookingNumber: bookingNumber,
        doctorId: widget.doctor.id,
        doctorName: widget.doctor.name,
        doctorSpecialty: widget.doctor.specialty,
        doctorImageUrl: widget.doctor.imageUrl,
        hospital: widget.doctor.hospital,
        appointmentDate: widget.appointmentDate,
        timeSlot: widget.timeSlot,
        patientName: _nameController.text.trim(),
        fatherName: _fatherNameController.text.trim(),
        cnic: _cnicController.text.trim(),
        fee: widget.doctor.fee,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, a, __) => ReceiptScreen(appointment: appointment),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
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
                boxShadow: AppTheme.softShadow),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textDark, size: 18),
          ),
        ),
        title: Text('Patient Info',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: AppTheme.textDark)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appointment summary card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primary.withOpacity(0.85),
                      AppTheme.primaryDark
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme.primary.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            widget.doctor.imageUrl,
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 54,
                              height: 54,
                              color: Colors.white24,
                              child: const Icon(Icons.person_rounded,
                                  color: Colors.white),
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              Text(widget.doctor.specialty,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                        Text('PKR ${widget.doctor.fee.toInt()}',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white24, height: 1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _summaryChip(
                            Icons.calendar_month_rounded,
                            '${widget.appointmentDate.day}/${widget.appointmentDate.month}/${widget.appointmentDate.year}'),
                        _summaryChip(
                            Icons.access_time_rounded, widget.timeSlot),
                        _summaryChip(Icons.location_on_rounded, 'Confirmed'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              Text('Patient Details',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark)),
              const SizedBox(height: 16),

              _formField(
                controller: _nameController,
                label: 'Patient Full Name',
                hint: 'e.g. Muhammad Ahmed',
                icon: Icons.person_outline_rounded,
                validator: (v) => v!.trim().isEmpty ? 'Enter patient name' : null,
              ),
              const SizedBox(height: 14),

              _formField(
                controller: _fatherNameController,
                label: "Father's Name",
                hint: "e.g. Muhammad Rafiq",
                icon: Icons.group_outlined,
                validator: (v) => v!.trim().isEmpty ? "Enter father's name" : null,
              ),
              const SizedBox(height: 14),

              _formField(
                controller: _cnicController,
                label: 'CNIC Number',
                hint: 'e.g. 3740512345678',
                icon: Icons.credit_card_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(13),
                ],
                validator: (v) {
                  if (v!.trim().isEmpty) return 'Enter CNIC number';
                  if (v.trim().length != 13) return 'CNIC must be 13 digits';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _bookNow,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : const Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 22),
                  label: Text(
                    _isLoading ? 'Booking...' : 'Book Now',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 5),
        Text(text,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _formField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.softShadow,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: GoogleFonts.poppins(color: AppTheme.textDark, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.primary, size: 20),
          filled: true,
          fillColor: AppTheme.cardBg,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: AppTheme.primary, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: AppTheme.error, width: 1.5)),
        ),
      ),
    );
  }
}
