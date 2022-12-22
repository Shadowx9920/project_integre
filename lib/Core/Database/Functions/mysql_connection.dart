import 'package:mysql1/mysql1.dart';

class MySqlConnectionAndroid {
  static String host = '10.0.2.2',
      user = 'root',
      password = 'root',
      db = 'projects7';
  static int port = 3306;

  MySqlConnectionAndroid();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}

class MySqlConnectionWeb {}
