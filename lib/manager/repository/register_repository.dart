
import 'package:graineasy/manager/base/base_repository.dart';

abstract class RegistrationRepository extends BaseRepository
{
  Future<String> registerUser(String firstName, String lastName,String email,String phoneNumber,String password);


}