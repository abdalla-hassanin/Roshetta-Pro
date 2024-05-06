import 'package:roshetta_pro/features/pharmacy/data/data_sources/pharmacy_data_source.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/repositories/pharmacy_repository.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  final PharmacyDataSource _dataSource;

  PharmacyRepositoryImpl(this._dataSource);

  @override
  Future<PrescriptionEntity> getPrescriptionByUserPhoneAndPrescriptionId(
      String mobilePhone, String prescriptionId) async {
    return await _dataSource.getPrescriptionByUserPhoneAndPrescriptionId(
        mobilePhone, prescriptionId);
  }
}
