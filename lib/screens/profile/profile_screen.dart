import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../widgets/soft_card.dart';
import '../auth/login_screen.dart';
import 'personal_info_screen.dart';
import 'appointment_history_screen.dart';
import 'terms_policies_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        title: Text('My Profile',
            style: GoogleFonts.poppins(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image & Name
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.cardBg,
                      boxShadow: AppTheme.softShadow,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const ClipOval(
                      child: Icon(Icons.person_rounded,
                          size: 80, color: AppTheme.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Muhammad Ahmed',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark)),
                  Text('user@example.com',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: AppTheme.textMedium)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Options
            _buildProfileOption(
                Icons.person_outline_rounded, 'Personal Information', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PersonalInfoScreen()),
              );
            }),
            _buildProfileOption(Icons.history_rounded, 'Appointment History',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AppointmentHistoryScreen()),
              );
            }),
            _buildProfileOption(Icons.description_outlined, 'Terms & Policies',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsPoliciesScreen()),
              );
            }),

            const SizedBox(height: 16),
            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                label: Text('Logout',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error.withValues(alpha: 0.9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SoftCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark)),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textLight, size: 24),
          ],
        ),
      ),
    );
  }
}
