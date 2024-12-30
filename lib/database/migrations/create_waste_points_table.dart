import 'package:vania/vania.dart';

class CreateWastePointsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('waste_points', () {
      id();
      char('name');
      char('type');
      char('latitude');
      char('longitude');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('waste_points');
  }
}