
import 'package:graineasy/manager/base/base_repository.dart';

abstract class LoginRepository extends BaseRepository
{
  Future<String> loginUser(String phone,String password);


}