import Cocoa

var greeting = "Hello, playground"


// Closure practice

var arr = [5,2,3,4]

// Assigning variable
var f = { ( arr : [Int]) -> Int in
    return arr.count
}
print(f(arr))


// Java syntax : (a,b) -> b-a - lambda. Here closures are lambda too but slightly diff

// Since argument tkaes closure, we can use trailing closure syntax
var newArr = arr.sorted { numb1, numb2 in
    numb1 > numb2
}

// Even shorter syntax. don't need to specify arguments if we use the $ syntax.
var newArr2 = arr.sorted { $0 > $1}

// Trailing closure with filter. applies this to every numb, which is each element
var newArr3 = arr.filter { numb in
    numb % 2 == 0
}

// Even shorter. $0 means each first argument
var newArr4 = arr.filter{ $0 % 2 == 0}

print(newArr)
print(newArr2)
print(newArr3)
print(newArr4)


// In trailing closure, we put function outside of parenthesis. We can even omit parenthesis if no inputs


//structs, computed properties, and property observers

// computed properties/ getter/setter
struct Employee {
    var name : String
    var vacationDaysTotal : Int
    var vacationDaysUsed : Int
    
    var vacationDaysRemaining : Int {
        get {
            vacationDaysTotal - vacationDaysUsed
        }
        
        // directly called when we are assigning a value to vacationDaysRemaining
        // it updates the other properties that it depends on so it remains consistent. that why below it updates vacationDaysUsed
        // because that value is used in teh getter
        // without setter, the property becomes read-only so directly assigning would give an error
        set(newVacationDaysRemaining){
            vacationDaysUsed = vacationDaysTotal - newVacationDaysRemaining
        }
    }
}



var person1 = Employee(name: "bob", vacationDaysTotal: 20, vacationDaysUsed: 0)
print(person1.vacationDaysRemaining)

person1.vacationDaysUsed += 2

print(person1.vacationDaysRemaining)

person1.vacationDaysRemaining = 13

print(person1.vacationDaysRemaining)
print(person1.vacationDaysUsed)


print("   ")

// property observers - didSet/ willSet
// didSet : called after value is updated
// willSet : called before value is updated
// cannot be used with computed properties unless they are inherited

struct Car {
    var status : Bool {
        didSet {
            if status == false {
                print("i changed to false")
            }
        }
        willSet {
            print("i am changing")
        }
    }
}

var bmw = Car(status: false)

bmw.status.toggle()
bmw.status.toggle()



// custom initializer


struct Phone {
    var model : String
    var size : Int?
    
    // Initializer with parameters defined and type like usual
    // here we can omit passing size but it is computed in init
    // the properties must be computed since it is not an optional
    init(model : String){
        self.model = model
//        if model == "iPhone" {
//            size = 5
//        } else {
//            size = 10
//        }
    }
}


var phone = Phone(model: "iPhone")
var phone2 = Phone(model: "Pixel")

// optional with nil-coalescing operator. since size is an optional, it will unwrap OR provide default if it is nil
print(phone.size ?? "invalid size")
print(phone2.size ?? "invalid size")





