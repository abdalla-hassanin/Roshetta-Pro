import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient/domain/use_cases/patient_use_cases.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(PatientInitial());


  Future<void> getPatientPrescriptions(String patientId) async {
    try {
      emit(GetPatientPrescriptionsLoading());
      final result =
          await getIt<GetPatientPrescriptionsUseCase>().call(patientId);
      emit(GetPatientPrescriptionsSuccess(result));
    } catch (e) {
      emit(GetPatientPrescriptionsError(e.toString()));
    }
  }

  Future<void> getPatientXRays(String patientId) async {
    try {
      emit(GetPatientXRaysLoading());
      final result = await getIt<GetPatientXRaysUseCase>().call(patientId);
      emit(GetPatientXRaysSuccess(result));
    } catch (e) {
      emit(GetPatientXRaysError(e.toString()));
    }
  }

  Future<void> getPatientMedicalHistory(String patientId) async {
    try {
      emit(GetPatientMedicalHistoryLoading());
      final result =
          await getIt<GetPatientMedicalHistoryUseCase>().call(patientId);
      emit(GetPatientMedicalHistorySuccess(result));
    } catch (e) {
      emit(GetPatientMedicalHistoryError(e.toString()));
    }
  }
}
