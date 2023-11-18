import Cocoa

var greeting = "Hello, playground"

// with all names
func add(age : Int, weight : Int) -> Int {
    return age + weight
}

func addTwo(_ age : Int, _ weight : Int) -> Int {
    return age + weight
}

func store(_ name1 : String, _ name2 : String) -> (String,String) {
    return (name1,name2)
}

print(add(age: 3, weight: 3))
print(addTwo(3, 10))
// decompose tuple
let (name1,name2) = (store("bob", "kenny"))
//print(name1 + " " + name2)

// assigns it to one variable
let group = (store("bob", "kenny"))
//print(group.0 + " " + group.1)

// function with default parameter.
func rand(_ name : String, _ name2  : String = "cat"){
    print(name + " " + name2)
}

rand("lucy")
rand("lucy", "head")



// Error handling
enum BookingErrors : Error {
    case taken, invalid
}
var set = Set<String>()

set.insert("NYC")
//
func tryBooking(_ name : String, _ booked : Set<String>) throws -> Bool {
    if booked.contains(name) {
        throw BookingErrors.taken
    }
    if name.count != 3{
        throw BookingErrors.invalid
    }
    
    return true
}
// gotta add try, then use do/catch block
do {
    var a = try tryBooking("1234", set)
    print(a)
} catch BookingErrors.invalid {
    print("not a valid name")
} catch BookingErrors.taken {
    print("name is taken")
}


print("")
enum NameError : Error {
    case invalidLength, invalidName
}

func randomEnumFunc(_ errorr : NameError){
    switch (errorr) {
    case .invalidName :
        print("name")
    case .invalidLength :
        print("length")
    }
}
var error = NameError.invalidName
randomEnumFunc(error)

func checkName(_ name : String) throws -> Bool {
    if name.count != 3 {
        throw NameError.invalidLength
    }
    if name.contains("bob") {
        throw NameError.invalidName
    }
    return true
}

do {
    try checkName("bob")
    print("great name!")
} catch NameError.invalidName {
    print("invalid name! cannot use bob")
} catch NameError.invalidLength {
    print("name too short")
}


