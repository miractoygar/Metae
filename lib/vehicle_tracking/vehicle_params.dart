

class VehicleParams{
  var last_speed = 0;
  var last_speed_update = 0;

  var last_speed_2 = 0;
  var last_speed_update_2 = 0;
  var last_brake = 0;


  void setBrake(brake){
    this.last_brake = brake;
  }
  void updateSpeed(speed, time){
    last_speed_2 = last_speed;
    last_speed_update_2 = last_speed_update;
    last_speed = speed;
    last_speed_update = time;
  }
}