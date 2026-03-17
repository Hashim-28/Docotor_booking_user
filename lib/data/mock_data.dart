import '../models/doctor.dart';

class MockData {
  static const List<Map<String, dynamic>> specialties = [
    {
      'id': 'cardiology',
      'name': 'Cardiologist',
      'icon': 'heart',
      'colorHex': 0xFFFFEBEE,
      'iconColorHex': 0xFFE53E3E,
    },
    {
      'id': 'neurology',
      'name': 'Neurologist',
      'icon': 'brain',
      'colorHex': 0xFFE8EAF6,
      'iconColorHex': 0xFF5C6BC0,
    },
    {
      'id': 'ent',
      'name': 'ENT Specialist',
      'icon': 'ear',
      'colorHex': 0xFFE0F7FA,
      'iconColorHex': 0xFF00ACC1,
    },
    {
      'id': 'orthopedic',
      'name': 'Orthopedic',
      'icon': 'bone',
      'colorHex': 0xFFFFF8E1,
      'iconColorHex': 0xFFFFB300,
    },
    {
      'id': 'dermatology',
      'name': 'Dermatologist',
      'icon': 'spa',
      'colorHex': 0xFFF3E5F5,
      'iconColorHex': 0xFF9C27B0,
    },
    {
      'id': 'ophthalmology',
      'name': 'Eye Specialist',
      'icon': 'eye',
      'colorHex': 0xFFE8F5E9,
      'iconColorHex': 0xFF43A047,
    },
    {
      'id': 'pediatrics',
      'name': 'Pediatrician',
      'icon': 'child',
      'colorHex': 0xFFFCE4EC,
      'iconColorHex': 0xFFEC407A,
    },
    {
      'id': 'gynecology',
      'name': 'Gynecologist',
      'icon': 'female',
      'colorHex': 0xFFE1F5FE,
      'iconColorHex': 0xFF039BE5,
    },
    {
      'id': 'psychiatry',
      'name': 'Psychiatrist',
      'icon': 'mental',
      'colorHex': 0xFFEDE7F6,
      'iconColorHex': 0xFF7E57C2,
    },
    {
      'id': 'general',
      'name': 'General Physician',
      'icon': 'stethoscope',
      'colorHex': 0xFFE0F2F1,
      'iconColorHex': 0xFF00897B,
    },
  ];

  static const List<Doctor> doctors = [
    // Cardiologists
    Doctor(
      id: 'd001',
      name: 'Dr. Ali Khan',
      specialty: 'Cardiologist',
      specialtyId: 'cardiology',
      hospital: 'Shifa International Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 312,
      fee: 1500,
      experience: '12 Years',
      about:
          'Dr. Ali Khan is a board-certified cardiologist with over 12 years of experience treating complex heart conditions. He specializes in interventional cardiology and preventive cardiology.',
      city: 'Islamabad',
      availableTimes: [
        '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
        '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM', '5:00 PM'
      ],
    ),
    Doctor(
      id: 'd002',
      name: 'Dr. Sara Ahmed',
      specialty: 'Cardiologist',
      specialtyId: 'cardiology',
      hospital: 'Aga Khan University Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 245,
      fee: 1500,
      experience: '9 Years',
      about:
          'Dr. Sara Ahmed is a compassionate cardiologist known for her patient-centered approach. She focuses on women\'s cardiovascular health and echocardiography.',
      city: 'Karachi',
      availableTimes: [
        '11:00 AM', '11:30 AM', '2:00 PM', '2:30 PM',
        '3:00 PM', '3:30 PM', '4:00 PM'
      ],
    ),
    Doctor(
      id: 'd003',
      name: 'Dr. Hassan Raza',
      specialty: 'Cardiologist',
      specialtyId: 'cardiology',
      hospital: 'CMH Rawalpindi',
      imageUrl:
          'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=400&h=400&fit=crop',
      rating: 4.7,
      reviewCount: 189,
      fee: 1500,
      experience: '15 Years',
      about:
          'Dr. Hassan Raza is a senior cardiologist with extensive experience in cardiac surgery and pacemaker implantation procedures.',
      city: 'Rawalpindi',
      availableTimes: [
        '8:30 AM', '9:00 AM', '9:30 AM',
        '5:00 PM', '5:30 PM', '6:00 PM'
      ],
    ),
    // Neurologists
    Doctor(
      id: 'd004',
      name: 'Dr. Zainab Malik',
      specialty: 'Neurologist',
      specialtyId: 'neurology',
      hospital: 'Shifa International Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 278,
      fee: 1500,
      experience: '11 Years',
      about:
          'Dr. Zainab Malik is a leading neurologist specializing in stroke management, epilepsy, and movement disorders. She is known for her diagnostic precision.',
      city: 'Islamabad',
      availableTimes: [
        '10:00 AM', '10:30 AM', '11:00 AM',
        '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM'
      ],
    ),
    Doctor(
      id: 'd005',
      name: 'Dr. Usman Farooq',
      specialty: 'Neurologist',
      specialtyId: 'neurology',
      hospital: 'Pakistan Institute of Medical Sciences',
      imageUrl:
          'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&h=400&fit=crop',
      rating: 4.7,
      reviewCount: 195,
      fee: 1500,
      experience: '8 Years',
      about:
          'Dr. Usman Farooq specializes in headache disorders, multiple sclerosis, and neurodegenerative diseases.',
      city: 'Lahore',
      availableTimes: [
        '9:00 AM', '9:30 AM', '2:00 PM', '2:30 PM', '3:00 PM'
      ],
    ),
    // ENT
    Doctor(
      id: 'd006',
      name: 'Dr. Amna Siddiqui',
      specialty: 'ENT Specialist',
      specialtyId: 'ent',
      hospital: 'Holy Family Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1527613426441-4da17471b66d?w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 220,
      fee: 1500,
      experience: '7 Years',
      about:
          'Dr. Amna Siddiqui is an expert ENT surgeon with special interest in rhinology, sinus surgery, and pediatric ENT.',
      city: 'Rawalpindi',
      availableTimes: [
        '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
        '4:00 PM', '4:30 PM', '5:00 PM'
      ],
    ),
    Doctor(
      id: 'd007',
      name: 'Dr. Tariq Mehmood',
      specialty: 'ENT Specialist',
      specialtyId: 'ent',
      hospital: 'Rawalpindi General Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400&h=400&fit=crop',
      rating: 4.6,
      reviewCount: 167,
      fee: 1500,
      experience: '10 Years',
      about:
          'Dr. Tariq Mehmood specializes in hearing disorders, cochlear implants, and head & neck oncology.',
      city: 'Rawalpindi',
      availableTimes: [
        '8:00 AM', '8:30 AM', '9:00 AM',
        '3:30 PM', '4:00 PM', '4:30 PM'
      ],
    ),
    // Orthopedic
    Doctor(
      id: 'd008',
      name: 'Dr. Bilal Sheikh',
      specialty: 'Orthopedic',
      specialtyId: 'orthopedic',
      hospital: 'Benazir Bhutto Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 298,
      fee: 1500,
      experience: '13 Years',
      about:
          'Dr. Bilal Sheikh is a renowned orthopedic surgeon specializing in joint replacements, sports injuries, and spine surgery.',
      city: 'Rawalpindi',
      availableTimes: [
        '9:30 AM', '10:00 AM', '10:30 AM',
        '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM'
      ],
    ),
    // Dermatologist
    Doctor(
      id: 'd009',
      name: 'Dr. Hira Baig',
      specialty: 'Dermatologist',
      specialtyId: 'dermatology',
      hospital: 'Islamabad Clinic',
      imageUrl:
          'https://images.unsplash.com/photo-1651008376811-b90baee60c1f?w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 341,
      fee: 1500,
      experience: '6 Years',
      about:
          'Dr. Hira Baig is a cosmetic and clinical dermatologist with expertise in laser treatments, acne, and skin cancer screenings.',
      city: 'Islamabad',
      availableTimes: [
        '11:00 AM', '11:30 AM', '12:00 PM',
        '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM'
      ],
    ),
    // Eye Specialist
    Doctor(
      id: 'd010',
      name: 'Dr. Aamir Iqbal',
      specialty: 'Eye Specialist',
      specialtyId: 'ophthalmology',
      hospital: 'Al-Shifa Eye Hospital',
      imageUrl:
          'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=400&h=400&fit=crop',
      rating: 4.8,
      reviewCount: 256,
      fee: 1500,
      experience: '14 Years',
      about:
          'Dr. Aamir Iqbal is a senior ophthalmologist specializing in cataract surgery, LASIK, and retinal diseases.',
      city: 'Rawalpindi',
      availableTimes: [
        '9:00 AM', '9:30 AM', '10:00 AM',
        '3:00 PM', '3:30 PM', '4:00 PM'
      ],
    ),
    // Pediatrician
    Doctor(
      id: 'd011',
      name: 'Dr. Rabia Noor',
      specialty: 'Pediatrician',
      specialtyId: 'pediatrics',
      hospital: 'Children Hospital Islamabad',
      imageUrl:
          'https://images.unsplash.com/photo-1551601651-2a8555f1a136?w=400&h=400&fit=crop',
      rating: 4.9,
      reviewCount: 389,
      fee: 1500,
      experience: '9 Years',
      about:
          'Dr. Rabia Noor is a beloved pediatrician known for her gentle approach. She specializes in neonatal care, childhood development, and vaccinations.',
      city: 'Islamabad',
      availableTimes: [
        '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
        '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM'
      ],
    ),
    // General Physician
    Doctor(
      id: 'd012',
      name: 'Dr. Kamran Javed',
      specialty: 'General Physician',
      specialtyId: 'general',
      hospital: 'Poly Clinic Islamabad',
      imageUrl:
          'https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?w=400&h=400&fit=crop',
      rating: 4.7,
      reviewCount: 412,
      fee: 1500,
      experience: '16 Years',
      about:
          'Dr. Kamran Javed is an experienced general physician with a wide-ranging practice covering internal medicine, preventive care, and chronic disease management.',
      city: 'Islamabad',
      availableTimes: [
        '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM',
        '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM'
      ],
    ),
  ];

  static List<Doctor> getDoctorsBySpecialty(String specialtyId) {
    return doctors.where((d) => d.specialtyId == specialtyId).toList();
  }

  static Doctor? getDoctorById(String id) {
    try {
      return doctors.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  static const List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Shifa International Hospital',
      'location': 'H-8/4, Islamabad',
      'rating': 4.8,
      'imageUrl':
          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=600&h=300&fit=crop',
      'specialties': 25,
      'beds': 450,
    },
    {
      'name': 'Aga Khan University Hospital',
      'location': 'Stadium Road, Karachi',
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=600&h=300&fit=crop',
      'specialties': 32,
      'beds': 700,
    },
    {
      'name': 'Pakistan Institute of Medical Sciences',
      'location': 'G-8/3, Islamabad',
      'rating': 4.6,
      'imageUrl':
          'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=600&h=300&fit=crop',
      'specialties': 28,
      'beds': 1500,
    },
    {
      'name': 'CMH Rawalpindi',
      'location': 'The Mall, Rawalpindi',
      'rating': 4.7,
      'imageUrl':
          'https://images.unsplash.com/photo-1504439468489-c8920d796a29?w=600&h=300&fit=crop',
      'specialties': 20,
      'beds': 600,
    },
    {
      'name': 'Benazir Bhutto Hospital',
      'location': 'Murree Road, Rawalpindi',
      'rating': 4.5,
      'imageUrl':
          'https://images.unsplash.com/photo-1516549655169-df83a0774514?w=600&h=300&fit=crop',
      'specialties': 18,
      'beds': 800,
    },
  ];

  // Dynamic history storage for this session
  static List<Map<String, String>> confirmedAppointments = [
    {
      'patientName': 'Ahmed Jamel',
      'fatherName': 'Jamel Uddin',
      'timeSlot': '09:00 AM - 09:30 AM',
      'date': '16 Mar 2026',
    },
    {
      'patientName': 'Marium Bibi',
      'fatherName': 'Ghulam Mustafa',
      'timeSlot': '10:30 AM - 11:00 AM',
      'date': '16 Mar 2026',
    },
  ];

  static List<Map<String, String>> cancelledAppointments = [
    {
      'patientName': 'Usman Khalid',
      'fatherName': 'Khalid Mehmood',
      'timeSlot': '03:00 PM - 03:30 PM',
      'date': '16 Mar 2026',
      'reason': 'Patient emergency',
    },
  ];

  static void addConfirmed(Map<String, String> appointment) {
    confirmedAppointments.insert(0, appointment);
  }

  static void addCancelled(Map<String, String> appointment) {
    cancelledAppointments.insert(0, appointment);
  }
}
