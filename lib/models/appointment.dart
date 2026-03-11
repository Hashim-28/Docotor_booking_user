class Appointment {
  final String bookingNumber;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImageUrl;
  final String hospital;
  final DateTime appointmentDate;
  final String timeSlot;
  final String patientName;
  final String fatherName;
  final String cnic;
  final double fee;

  const Appointment({
    required this.bookingNumber,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImageUrl,
    required this.hospital,
    required this.appointmentDate,
    required this.timeSlot,
    required this.patientName,
    required this.fatherName,
    required this.cnic,
    required this.fee,
  });
}
