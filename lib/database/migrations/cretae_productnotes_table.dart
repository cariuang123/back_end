import 'package:vania/vania.dart';

class CretaeProductnotesTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('cretae_productnotes', () {
      id();
      char("prod_id");
      date("note_date");
      text("note_text");
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('cretae_productnotes');
  }
}
