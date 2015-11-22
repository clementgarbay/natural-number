//
//  main.swift
//  NaturalNumber
//
//  Created by Clément GARBAY on 21/11/2015.
//  Copyright © 2015 Clément GARBAY. All rights reserved.
//

indirect enum Nat: IntegerLiteralConvertible, CustomStringConvertible {
    case Zero;
    case Succ(Nat);
    
    init(integerLiteral value: Int) {
        self = Nat.fromInt(value)
    }
    
    static func fromInt (n: Int, accum: Nat = .Zero) -> Nat {
        if n == 0 {
            return accum
        }
        return Nat.fromInt(n-1, accum: .Succ(accum))
    }
    
    static func toInt (n: Nat) -> Int {
        if n == 0 {
            return 0
        }
        return 1 + Nat.toInt(n-1)
    }
    
    var integerValue: Int {
        return Nat.toInt(self)
    }
    
    var description: String {
        return String(integerValue)
    }
}

// Definition of the plus operator
func + (a: Nat, b: Nat) -> Nat {
    switch (a,b) {
    case (_, .Zero):
        return a
    case (.Zero, _):
        return b
    case let (.Succ(pred_a), _):
        return pred_a + .Succ(b)
    }
}

// Definition of the minus operator
func - (a: Nat, b: Nat) -> Nat {
    switch (a, b) {
    case (.Zero, .Zero), (.Zero, .Succ):
        return .Zero
    case (.Succ, .Zero):
        return a
    case let (.Succ(pred_a), .Succ(pred_b)):
        return pred_a - pred_b
    }
}

// Definition of the times operator
func * (a: Nat, b: Nat) -> Nat {
    switch (a, b) {
    case (_, .Zero), (.Zero, _):
        return .Zero
    case let (.Succ(pred_a), _):
        return pred_a * b + b
    }
}

// Definition of the pow operator
func ^ (a: Nat, b: Nat) -> Nat {
    switch (a, b) {
    case (_, .Zero):
        return .Succ(.Zero)
    case (.Zero, .Succ):
        return .Zero
    case let (.Succ, .Succ(pred_b)):
        return a * (a ^ pred_b)
    }
}

// Implement the Equatable protocol
extension Nat : Equatable {}
func == (a: Nat, b: Nat) -> Bool {
    switch (a, b) {
    case (.Zero, .Zero):
        return true
    case (.Zero, .Succ), (.Succ, .Zero):
        return false
    case let (.Succ(pred_a), .Succ(pred_b)):
        return pred_a == pred_b
    }
}

// Implement the Comparable protocol
extension Nat : Comparable {}
func < (a: Nat, b: Nat) -> Bool {
    switch (a, b) {
    case (.Zero, .Succ):
        return true
    case (_, .Zero):
        return false
    case let (.Succ(pred_a), .Succ(pred_b)):
        return pred_a < pred_b
    }
}

// Distance (the absolute value of the difference between two Nat )
func distance (a: Nat, _ b: Nat) -> Nat {
    if a > b {
        return a - b
    }
    return b - a
}

// Definition of the modulus operator
func % (a: Nat, b: Nat) -> Nat {
    if a < b {
        return a
    }
    return distance(a, b) % b
}


// Predecessor function
func pred (n: Nat) -> Nat? {
    switch n {
    case .Zero:
        return nil
    case let .Succ(pred):
        return pred
    }
}


//// Examples

let zero: Nat = .Zero
let one: Nat = .Succ(.Zero)
let two: Nat = .Succ(.Succ(.Zero))

let three: Nat = 3
let four: Nat = 4
let five: Nat = 5

print("one + two : ", one + two)
print("four - two : ", four - two)
print("four * zero : ", four * zero)
print("four * one : ", four * one)
print("four * two : ", four * two)

print("two ^ one : ", two ^ one)
print("two ^ four : ", two ^ four)
print("three ^ two : ", three ^ two)

print("two == one : ", two == one)
print("two == two : ", two == two)
print("two != one : ", two != one)

print("two % two : ", two % two)
print("one % two : ", one % two)
print("(five + five) % four : ", (five + five) % four)

print("two < one : ", two < one)
print("one < three : ", one < three)
print("one > three : ", one > three)
print("two > two : ", two > two)

print("min(two, three) : ", min(two, three))
print("max(one, two, three) : ", max(one, two, three))

print("pred(.Zero) : ", pred(.Zero))
print("pred(three) : ", pred(three))

print("distance(three, one) : ", distance(three, one))
print("distance(two, one) == distance(one, two) : ", distance(two, one) == distance(one, two))


