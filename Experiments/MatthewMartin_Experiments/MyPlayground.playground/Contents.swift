//: Playground - noun: a place where people can play

import UIKit

var a = 1
var b = 2

var sum = a + b
print(sum)

var money = 50 //Amount of money have
var slicePizzaCost = 5

if money >= slicePizzaCost {
    print("Pays for slice of pizza")
    money -= slicePizzaCost
} else {
    print("Not enough money")
}
