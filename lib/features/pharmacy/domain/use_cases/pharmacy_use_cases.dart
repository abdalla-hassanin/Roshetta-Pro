import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/repositories/pharmacy_repository.dart';

class GetPrescriptionByUserPhoneAndPrescriptionIdUseCase {
  final PharmacyRepository _repository;

  GetPrescriptionByUserPhoneAndPrescriptionIdUseCase(this._repository);

  Future<PrescriptionEntity> call(String mobilePhone, String prescriptionId) async {
      return await _repository.getPrescriptionByUserPhoneAndPrescriptionId(
          mobilePhone, prescriptionId);
  }
}
