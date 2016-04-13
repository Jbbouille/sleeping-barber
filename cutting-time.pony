use "time"

class CuttingTime is TimerNotify  
  let _env: Env
  let _barberShop: BarberShop
  let _customerName: String

  new iso create(env: Env, barberShop: BarberShop, customerName: String) =>
    _env = env
    _barberShop = barberShop
    _customerName = customerName

  fun ref apply(timer: Timer, count: U64): Bool =>
    _barberShop.finish(_customerName)
    false