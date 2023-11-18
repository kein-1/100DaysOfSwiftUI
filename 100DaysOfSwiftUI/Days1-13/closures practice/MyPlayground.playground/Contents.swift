import Cocoa

var greeting = "Hello, playground"


var arr = [1,2,3,4,5]

var updatedArr = arr.filter { numb in
    numb % 2 == 0
}

var strings = ["cat", "doggy", "tiger!", "animals"]

strings.sort { string1, string2 in
    string1.count > string2.count
}

print(strings)



func random(_ numb : Int, _ closure : (Int) -> Int) -> Int {
    return closure(numb)
}

var numb = 10

var val = random(numb){value in
    value * 2
}

print(val)


