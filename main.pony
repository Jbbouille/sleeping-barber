actor Main
  new create(env: Env) =>
    let barberShop = BarberShop(env, 5)
    let henri = Customer("Henri", env, barberShop)
    let paul = Customer("Paul", env, barberShop)
    let jacques = Customer("Jacques", env, barberShop)
    let thierry = Customer("Thierry", env, barberShop)
    let jean = Customer("Jean", env, barberShop)
    let charles = Customer("Charles", env, barberShop)
    let george = Customer("George", env, barberShop)