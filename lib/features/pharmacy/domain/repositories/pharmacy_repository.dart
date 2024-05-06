import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';

abstract class PharmacyRepository {
  Future<PrescriptionEntity> getPrescriptionByUserPhoneAndPrescriptionId(String mobilePhone,String prescriptionId);
}
