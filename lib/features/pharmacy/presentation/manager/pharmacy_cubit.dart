import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/use_cases/pharmacy_use_cases.dart';

part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PharmacyInitial());


  Future<void> getPrescriptionByUserPhoneAndPrescriptionId(
      String mobilePhone, String prescriptionId) async {
    try {
      emit(GetPrescriptionByUserPhoneAndPrescriptionIdLoading());
      final result =
          await getIt<GetPrescriptionByUserPhoneAndPrescriptionIdUseCase>()
              .call(mobilePhone, prescriptionId);
      emit(GetPrescriptionByUserPhoneAndPrescriptionIdSuccess(result));
    } catch (e) {
      emit(GetPrescriptionByUserPhoneAndPrescriptionIdError(e.toString()));
    }
  }
}
