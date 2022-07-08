import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:zoncan/security/security.dart' show UserDetailsModel;

part 'model_serializers.g.dart';

@SerializersFor([
  UserDetailsModel,
])
Serializers _serializers = _$_serializers;
class ModelSerializer {
  static Serializers serializers = _serializers;

  static Serializers standardSerializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
}
