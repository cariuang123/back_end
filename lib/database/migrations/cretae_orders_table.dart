import 'package:vania/vania.dart';

class CretaeOrdersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_orders', () {
      id();
      date("order_date");
      char("cust_id");
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_orders');
  }
}
