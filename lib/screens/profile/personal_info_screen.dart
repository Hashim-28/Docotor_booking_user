import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Muhammad Ahmed');
    _emailController = TextEditingController(text: 'user@example.com');
    _phoneController = TextEditingController(text: '+92 314 8272532');
    _genderController = TextEditingController(text: 'Male');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    super.dispose();
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
        title: Text('Personal Information',
            style: GoogleFonts.poppins(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes saved successfully')),
                  );
                }
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(
              _isEditing ? Icons.check_rounded : Icons.edit_rounded,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoField('Full Name', _nameController, Icons.person_outline),
              _buildInfoField('Email Address', _emailController, Icons.email_outlined),
              _buildInfoField('Phone Number', _phoneController, Icons.phone_outlined),
              _buildGenderDropdown(),
              const SizedBox(height: 32),
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        _genderController.text = _selectedGender;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Changes saved successfully')),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _selectedGender = 'Male';
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMedium,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedGender,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: AppTheme.primary),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.male_outlined, color: AppTheme.primary, size: 20),
              filled: true,
              fillColor: AppTheme.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppTheme.primary, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: _genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(
                  gender,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: _isEditing
                ? (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMedium,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            enabled: _isEditing,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppTheme.textDark,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppTheme.primary, size: 20),
              filled: true,
              fillColor: AppTheme.cardBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppTheme.primary, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
