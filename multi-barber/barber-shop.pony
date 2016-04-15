actor BarberShop
  let _env: Env
  let _availability: Array[Barber]
  let _waitingRoom: Array[Customer]

  new create(env: Env, waitingRoomSize: U64, barbersNumber: U64) =>
    _env = env
    _waitingRoom = Array[Customer](waitingRoomSize)
    _availability = Array[Barber](barbersNumber)

  be handle_client(customer: Customer, name: String) =>
    if _availability.size() <= 0 then
      all_barbers_occupied(customer, name)
      return
    end
    try
      _availability.shift().cut_hair(customer, name)
    end

  fun ref all_barbers_occupied(customer: Customer, name: String) =>
    if _waitingRoom.size() < _waitingRoom.space() then
      _waitingRoom.push(customer)
      _env.out.print(name+": I go in the waiting room, left space "+(_waitingRoom.space()-_waitingRoom.size()).string()+".")
    else
      _env.out.print(name+": No more space in the waiting room, I leave the office!")
    end

  be barber_available(barber: Barber, barberName: String) =>
    _availability.push(barber)
    if _waitingRoom.size() > 0 then
      try
        _waitingRoom.shift().cut_my_hair()
      end
    end