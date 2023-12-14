import Cocoa

var greeting = "Hello, playground"


let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for _ in platforms {
    print("hi")
}

for ind in platforms.indices {
    print(ind)
}

for ind in 0..<platforms.count{
    print(ind)
}


var numb : Double = 30.0
print(numb.size)
numb.random { numb in
    numb * 2.0
}

var arr = [1,2,3,4,5]

var doubles = arr.map { numb -> String in
    String(numb)
}

print(doubles)
