import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/doctor.dart';
import '../doctors/specialty_doctors_screen.dart';
import '../doctors/hospital_doctors_screen.dart';
import '../profile/profile_screen.dart';
import '../doctors/doctor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0; // 0=Doctors, 1=Hospitals
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Doctor> _filteredDoctors = [];
  List<Map<String, dynamic>> _filteredHospitals = [];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();

    _filteredDoctors = MockData.doctors;
    _filteredHospitals = MockData.hospitals;
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredDoctors = MockData.doctors;
        _filteredHospitals = MockData.hospitals;
      } else {
        _filteredDoctors = MockData.doctors
            .where((d) =>
                d.name.toLowerCase().contains(query.toLowerCase()) ||
                d.specialty.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _filteredHospitals = MockData.hospitals
            .where((h) => h['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          slivers: [
            // SliverAppBar & Header
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildToggleTabs()),
            if (_searchQuery.isNotEmpty) ...[
              SliverToBoxAdapter(child: _buildSectionTitle('Search Results')),
              if (_filteredDoctors.isNotEmpty) ...[
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Text('Doctors',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary)),
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: _DoctorSearchCard(doctor: _filteredDoctors[index]),
                    ),
                    childCount: _filteredDoctors.length,
                  ),
                ),
              ],
              if (_filteredHospitals.isNotEmpty) ...[
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
                  child: Text('Hospitals',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary)),
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _HospitalCard(hospital: _filteredHospitals[index]),
                    ),
                    childCount: _filteredHospitals.length,
                  ),
                ),
              ],
              if (_filteredDoctors.isEmpty && _filteredHospitals.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No results found for "$_searchQuery"',
                        style: GoogleFonts.poppins(color: AppTheme.textMedium)),
                  ),
                ),
            ] else ...[
              if (_selectedTab == 0) ...[
                SliverToBoxAdapter(child: _buildSectionTitle('Browse by Specialty')),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: _buildSpecialtyGrid(),
                ),
              ] else ...[
                SliverToBoxAdapter(child: _buildSectionTitle('Top Hospitals')),
                SliverToBoxAdapter(child: _buildHospitalsList()),
              ],
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryDark, AppTheme.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Evening 👋',
                          style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13)),
                      Text('Find Your Doctor',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5), width: 1.5),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style:
                      GoogleFonts.poppins(color: AppTheme.textDark, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search doctors, hospitals...',
                    hintStyle: GoogleFonts.poppins(
                        color: AppTheme.textLight, fontSize: 14),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppTheme.primary, size: 22),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: AppTheme.textLight, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.tune_rounded,
                                color: Colors.white, size: 16),
                          ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildToggleTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Container(
        height: 54,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppTheme.softShadow,
        ),
        child: Row(
          children: [
            _tabButton(0, Icons.medical_services_rounded, 'Doctors'),
            _tabButton(1, Icons.local_hospital_rounded, 'Hospitals'),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(int index, IconData icon, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: AppTheme.primary.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected ? Colors.white : AppTheme.textMedium,
                  size: 18),
              const SizedBox(width: 7),
              Text(label,
                  style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : AppTheme.textMedium,
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
      child: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark)),
    );
  }

  SliverGrid _buildSpecialtyGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.15,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final spec = MockData.specialties[index];
          return _SpecialtyCard(
            specialty: spec,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SpecialtyDoctorsScreen(
                  specialtyId: spec['id'],
                  specialtyName: spec['name'],
                ),
              ),
            ),
          );
        },
        childCount: MockData.specialties.length,
      ),
    );
  }

  Widget _buildHospitalsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: MockData.hospitals.length,
      itemBuilder: (context, index) {
        final hospital = MockData.hospitals[index];
        return _HospitalCard(hospital: hospital);
      },
    );
  }
}

// ============================================================
// Specialty Card
// ============================================================

class _SpecialtyCard extends StatelessWidget {
  final Map<String, dynamic> specialty;
  final VoidCallback onTap;

  const _SpecialtyCard({required this.specialty, required this.onTap});

  IconData _getIcon(String name) {
    switch (name) {
      case 'heart':
        return Icons.favorite_rounded;
      case 'brain':
        return Icons.psychology_rounded;
      case 'ear':
        return Icons.hearing_rounded;
      case 'bone':
        return Icons.accessibility_new_rounded;
      case 'spa':
        return Icons.spa_rounded;
      case 'eye':
        return Icons.visibility_rounded;
      case 'child':
        return Icons.child_care_rounded;
      case 'female':
        return Icons.pregnant_woman_rounded;
      case 'mental':
        return Icons.self_improvement_rounded;
      case 'stethoscope':
        return Icons.health_and_safety_rounded;
      default:
        return Icons.medical_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(specialty['colorHex'] as int);
    final iconColor = Color(specialty['iconColorHex'] as int);
    final icon = _getIcon(specialty['icon'] as String);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppTheme.softShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                specialty['name'] as String,
                style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('View Doctors',
                      style: GoogleFonts.poppins(
                          color: AppTheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_rounded,
                      color: AppTheme.primary, size: 12),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Hospital Card
// ============================================================

class _HospitalCard extends StatelessWidget {
  final Map<String, dynamic> hospital;

  const _HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HospitalDoctorsScreen(hospitalName: hospital['name'] as String),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.softShadow,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                hospital['imageUrl'] as String,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  color: AppTheme.primaryLight,
                  child: const Icon(Icons.local_hospital_rounded,
                      color: AppTheme.primary, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hospital['name'] as String,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppTheme.textDark)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                color: AppTheme.textLight, size: 14),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(hospital['location'] as String,
                                  style: GoogleFonts.poppins(
                                      color: AppTheme.textMedium, fontSize: 12),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _infoChip(
                                '${hospital['specialties']} Specialties', Icons.star_rounded),
                            const SizedBox(width: 8),
                            _infoChip(
                                '${hospital['beds']} Beds', Icons.bed_rounded),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppTheme.star, size: 16),
                        const SizedBox(width: 4),
                        Text('${hospital['rating']}',
                            style: GoogleFonts.poppins(
                                color: AppTheme.textDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.primary, size: 12),
          const SizedBox(width: 4),
          Text(text,
              style: GoogleFonts.poppins(
                  color: AppTheme.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ============================================================
// Search Result Doctor Card
// ============================================================

class _DoctorSearchCard extends StatelessWidget {
  final Doctor doctor;

  const _DoctorSearchCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DoctorDetailScreen(doctor: doctor)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppTheme.softShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  doctor.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: AppTheme.primaryLight,
                    child: const Icon(Icons.person_rounded,
                        color: AppTheme.primary, size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppTheme.textDark)),
                    const SizedBox(height: 2),
                    Text(doctor.specialty,
                        style: GoogleFonts.poppins(
                            color: AppTheme.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(doctor.hospital,
                        style: GoogleFonts.poppins(
                            color: AppTheme.textMedium, fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppTheme.star, size: 14),
                      const SizedBox(width: 2),
                      Text('${doctor.rating}',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppTheme.textLight, size: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
