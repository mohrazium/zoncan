import 'package:zoncan/common/common.dart' show Service;

import '../../domain/domain.dart' show UserDetailsModel;

abstract class UserDetailsService extends Service<String, UserDetailsModel>{}

class UserDetailsServiceImpl implements UserDetailsService{
  @override
  Future<bool> delete(UserDetailsModel model) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UserDetailsModel?>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<UserDetailsModel?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<UserDetailsModel> save(UserDetailsModel model) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<bool> update(UserDetailsModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }


}