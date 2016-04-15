actor Customer
  let _name: String
  let _barberShop: BarberShop

  new create(name: String, env: Env, barberShop: BarberShop) =>
    _barberShop = barberShop
    _name = name
    env.out.print(_name+": Hello.")
    _barberShop.handle_client(this, _name)

  be cut_my_hair() =>
    _barberShop.handle_client(this, _name)
