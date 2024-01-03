
import 'dart:io';

class SignUpModel
{
  DateTime? _birthdayDate;
  File? _userPickerImage;
  bool _isBirthdaySelected = false;

  SignUpModel()
  {
    _birthdayDate = DateTime.now();
    _userPickerImage = null;
    _isBirthdaySelected = false;
  }

  void setBirthday(DateTime time)
  {
    _birthdayDate = time;
  }

  void setUserPickerImage(String filePath)
  {
    _userPickerImage = File(filePath);
  }

  void setBirthdaySelected(bool isSelected)
  {
    _isBirthdaySelected = isSelected;
  }

  DateTime? get getBirthdayDate => _birthdayDate;
  File? get getUserPickerImage => _userPickerImage;
  bool get isBirthdaySelected => _isBirthdaySelected;
}