import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration3 extends Migration { 
  @override
  Future upgrade() async {
   		database.deleteColumn("_User", "socialNetworks");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    