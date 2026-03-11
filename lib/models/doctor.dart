class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String specialtyId;
  final String hospital;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double fee;
  final String experience;
  final String about;
  final List<String> availableTimes;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.specialtyId,
    required this.hospital,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.fee,
    required this.experience,
    required this.about,
    required this.availableTimes,
  });
}
