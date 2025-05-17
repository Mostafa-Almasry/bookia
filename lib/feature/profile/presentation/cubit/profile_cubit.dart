import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookia/feature/profile/data/model/change_password/change_password.dart';
import 'package:bookia/feature/profile/data/model/contact_us/contact_us_request.dart';
import 'package:bookia/feature/profile/data/model/get_profile/get_profile_response.dart';
import 'package:bookia/feature/profile/data/model/update_profile/update_profile.dart';
import 'package:bookia/feature/profile/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  GetProfileResponse? profileResponse;

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    await ProfileRepo.getProfile().then((value) {
      log(value.toString());
      if (value != null) {
        profileResponse = value;
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState('error'));
      }
    });
  }

  Future<void> updateProfile(UpdateProfile data) async {
    emit(ProfileLoadingState());
    await ProfileRepo.updateProfile(data).then((value) {
      log(value.toString());
      if (value != null) {
        profileResponse = value;
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState('error'));
      }
    });
  }

  Future<void> changePassword(ChangePasswordRequest data) async {
    emit(ProfileLoadingState());
    await ProfileRepo.changePassword(data).then((value) {
      log(value.toString());
      if (value != null) {
        profileResponse = value;
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState('error'));
      }
    });
  }

  Future<void> contactUs(ContactUsRequest data) async {
    emit(ProfileLoadingState());
    await ProfileRepo.contactUs(data).then((value) {
      log(value.toString());
      if (value = true) {
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState('error'));
      }
    });
  }
}
