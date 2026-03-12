import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/doctor.dart';
import 'doctor_detail_screen.dart';

class SpecialtyDoctorsScreen extends StatelessWidget {
  final String specialtyId;
  final String specialtyName;

  const SpecialtyDoctorsScreen({
    super.key,
    required this.specialtyId,
    required this.specialtyName,
  });

  @override
  Widget build(BuildContext context) {
    final doctors = MockData.getDoctorsBySpecialty(specialtyId);

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
            Text(specialtyName,
                style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
            Text('${doctors.length} Doctors Available',
                style: GoogleFonts.poppins(
                    color: AppTheme.textMedium, fontSize: 12)),
          ],
        ),
      ),
      body: doctors.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_search_rounded,
                      size: 60, color: AppTheme.textLight),
                  const SizedBox(height: 12),
                  Text('No doctors available',
                      style: GoogleFonts.poppins(color: AppTheme.textMedium)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: doctors.length,
              itemBuilder: (context, i) =>
                  _DoctorListCard(doctor: doctors[i]),
            ),
    );
  }
}

class _DoctorListCard extends StatelessWidget {
  final Doctor doctor;

  const _DoctorListCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DoctorDetailScreen(doctor: doctor)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppTheme.softShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Doctor photo
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  doctor.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.person_rounded,
                        color: AppTheme.primary, size: 36),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 3),
                    Text(doctor.specialty,
                        style: GoogleFonts.poppins(
                            color: AppTheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: AppTheme.textLight, size: 12),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(doctor.hospital,
                              style: GoogleFonts.poppins(
                                  color: AppTheme.textMedium, fontSize: 11),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.star.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded,
                                  color: AppTheme.star, size: 14),
                              const SizedBox(width: 3),
                              Text('${doctor.rating}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Fee
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                              'PKR ${doctor.fee.toInt()}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primary)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppTheme.textLight, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
