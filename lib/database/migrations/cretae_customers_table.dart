import 'package:vania/vania.dart';

class CretaeCustomersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_customers', () {
      id();
      char("cust_name");
      char("cust_address");
      char("cust_city");
      char("cust_state");
      char("cust_zip");
      char("cust_country");
      char("cust_telp");

      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_customers');
  }
}
