use "time"

actor BarberShop
  let _env: Env
  let _chair: Chair = Chair
  let _waitingRoom: Array[Customer]

  new create(env: Env, waitingRoomSize: U64) =>
    _env = env
    _waitingRoom = Array[Customer](waitingRoomSize)

  be handle_client(customer: Customer, name: String) =>
    if _chair.is_occupied() then
      _env.out.print("Barber: I am occupied "+name+" go in the waiting room.")
      if _waitingRoom.size() < 5 then
        _waitingRoom.push(customer)
        _env.out.print(name+": I go in the waiting room, left space "+_waitingRoom.size().string()+".")
        return
      else
        _env.out.print(name+": No more space in the waiting room, I leave the office!")
          return
      end
    end

    _env.out.print("Barber: I am gonna cut your hair "+name+"!")
    cut_hair(customer, name)

  fun ref cut_hair(customer: Customer, name: String) =>
    _chair.set_occupation(customer)
    let timers = Timers
    let timer = Timer(CuttingTime(_env, this, name), 20, 5_000_000_000)
    timers(consume timer)

  be finish(name: String) =>
    _chair.set_occupation(None)
    _env.out.print("Barber: Finish to cut the hair to " + name)
    if _waitingRoom.size() > 0 then
      try
        _waitingRoom.pop().cut_my_hair()
      end
    else
      _env.out.print("Barber: No more people in my office I go to sleep.")
    end