actor Main
  new create(env: Env) =>
    let barberShop = BarberShop(env, 100, 20)

    var count: U32 = 1
    while count <= 20 do
      Barber(env, "barber_"+count.string(), barberShop)
      count = count + 1
    end    

    count = 1
    while count <= 100 do
      Customer("customer_"+count.string(), env, barberShop)
      count = count + 1
    end