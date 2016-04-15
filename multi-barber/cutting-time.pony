use "time"

class CuttingTime is TimerNotify  
  var _firstRound: Bool = true
  let _barber: Barber
  let _customerName: String

  new iso create(barber: Barber, customerName: String) =>
    _barber = barber
    _customerName = customerName

  fun ref apply(timer: Timer, count: U64): Bool =>
    if _firstRound == true then 
      _firstRound = false
      true
    else
      _barber.finish(_customerName)
      false
    end