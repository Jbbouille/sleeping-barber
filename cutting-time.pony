use "time"

class CuttingTime is TimerNotify  
  var _firstRound: Bool = true
  let _barberShop: BarberShop
  let _customerName: String

  new iso create(barberShop: BarberShop, customerName: String) =>
    _barberShop = barberShop
    _customerName = customerName

  fun ref apply(timer: Timer, count: U64): Bool =>
    if _firstRound == true then 
      _firstRound = false
      true
    else
      _barberShop.finish(_customerName)
      false
    end