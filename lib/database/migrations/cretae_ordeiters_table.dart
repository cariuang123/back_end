import 'package:vania/vania.dart';

class CretaeOrdeitersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_ordeiters', () {
      id();
      integer("order_num");
      char("prod_id");
      integer("quantity");
      integer("size");

      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_ordeiters');
  }
}
