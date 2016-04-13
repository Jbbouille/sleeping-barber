type  Occupation is (Customer | None)

class Chair
  var _occupation: Occupation
  
  new create() =>
    _occupation = None

  fun get_occupation(): Occupation => 
    _occupation
  
  fun ref set_occupation(occupation: Occupation) =>
    _occupation = occupation
  
  fun is_occupied(): Bool => 
    match _occupation
    | None => false
    else
      true
    end
