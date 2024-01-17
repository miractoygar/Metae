
import 'package:deliver/main.dart';

class BrakeChecker{
   int checkBrake(){
     var params = Checker.vehicle_params;
     int difspeed = params.last_speed_2 - params.last_speed;
     int diftime = params.last_speed_update - params.last_speed_update_2;
     if(difspeed >= params.last_speed_2 && difspeed != 0 && diftime < 4){
       return 100;
     }
     if(difspeed <= 0){
       return 0;
     }
     if(diftime < 4){
       var spdtdiff = difspeed / diftime;
        return (spdtdiff / (params.last_speed_2 / 100)).round();
     }
    return 0;
  }

  bool isHardBrake(){
    var params = Checker.vehicle_params;
    int difspeed = params.last_speed_2 - params.last_speed;
    int diftime = params.last_speed_update - params.last_speed_update_2;


    return false;
  }
}