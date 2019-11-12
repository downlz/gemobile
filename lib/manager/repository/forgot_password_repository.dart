
import 'package:graineasy/manager/base/base_repository.dart';

abstract class ForgotPasswordRepository extends BaseRepository
{
  Future<String> forgotPassword(String phone,String pan,String gstin,String password);


}