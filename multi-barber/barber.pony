use "time"

actor Barber
  let _env: Env
  let _shop: BarberShop
  let _barberName: String
  var _chair: (None | Customer)

  new create(env: Env, barberName: String, barberShop: BarberShop) =>
    _env = env
    _chair = None
    _barberName = barberName
    _shop = barberShop
    _shop.barber_available(this, _barberName)

  be cut_hair(customer: Customer, name: String) =>
    match _chair
    | None => _cut_hair(customer, name)
    else
      _env.out.print(_barberName+": That's embarrasing !")
    end

  fun ref _cut_hair(customer: Customer, name: String) =>
    _env.out.print(_barberName+": I am gonna cut your hair "+name+"!")
    _chair = customer
    let timers = Timers
    let timer = Timer(CuttingTime(this, name), 0, 3_000_000_000)
    timers(consume timer)

  be finish(name: String) =>
    _chair = None
    _env.out.print(_barberName+": Finish to cut the hair to " + name)
    _shop.barber_available(this, _barberName)
