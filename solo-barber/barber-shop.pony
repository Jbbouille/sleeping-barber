use "time"

actor BarberShop
  let _env: Env
  var _chair: (None|Customer)
  let _waitingRoom: Array[Customer]

  new create(env: Env, waitingRoomSize: U64) =>
    _env = env
    _waitingRoom = Array[Customer](waitingRoomSize)
    _chair = None

  be handle_client(customer: Customer, name: String) =>
    match _chair
    | None => cut_hair(customer, name)
    else
      barber_occupied(customer, name)
    end

  fun ref barber_occupied(customer: Customer, name: String) =>
    if _waitingRoom.size() < 5 then
      _waitingRoom.push(customer)
      _env.out.print(name+": I go in the waiting room, left space "+(_waitingRoom.space()-_waitingRoom.size()).string()+".")
    else
      _env.out.print(name+": No more space in the waiting room, I leave the office!")
    end

  fun ref cut_hair(customer: Customer, name: String) =>
    _env.out.print("Barber: I am gonna cut your hair "+name+"!")
    _chair = customer
    let timers = Timers
    let timer = Timer(CuttingTime(this, name), 0, 3_000_000_000)
    timers(consume timer)

  be finish(name: String) =>
    _chair = None
    _env.out.print("Barber: Finish to cut the hair to " + name)
    if _waitingRoom.size() > 0 then
      try
        _waitingRoom.shift().cut_my_hair()
      end
    else
      _env.out.print("Barber: No more people in my office I go to sleep.")
    end