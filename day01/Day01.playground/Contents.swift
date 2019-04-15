//: Playground - noun: a place where people can play
//import Foundation
//ex00
import UIKit

enum Color : String {
    case Spade = "spade"
    case Heart = "heart"
    case Diamond = "diamond"
    case Club = "club"

    static let allColors : [Color] = [Spade, Heart, Diamond, Club]
}

enum Value : Int {
    case Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
    
    static let allValues : [Value] = [Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King]
}

//var arrayValue : [Value] = Value.allValues
//var arrayColor : [Color] = Color.allColors
//
//for value in arrayValue {
//    print (value, "is", value.rawValue)
//}
//
//for color in arrayColor {
//    print (color, "is", color.rawValue)
//}

//for color in Color.allColors {
//    print (color.rawValue)
//}
//
//for value in Value.allValues {
//    print (value, "is", value.rawValue)
//}

//print("---------------------------------------------------------------------------------------------------------------")
//ex01

class Card : NSObject {
    var color: Color
    var value: Value
    
    init(color: Color, value: Value){
        self.color = color
        self.value = value
    }
    
    override var description: String {
        if value.rawValue > 10 || value.rawValue < 2 {
            return "(\(value), \(color))"
        } else {
            return "(\(value.rawValue), \(color))"
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return(self.color == object.color && self.value == object.value)
        } else {
            return false
        }
    }
}

//func ==(card1: Card, card2: Card) -> Bool
//{
//    return (card1.color == card2.color && card1.value == card2.value)
//}

let card1 = Card(color: Color.Heart, value : Value.Seven)
let card2 = Card(color: Color.Diamond, value: Value.Ace)
let card3 = Card(color: Color.Heart, value : Value.Seven)
let card4 = Card(color: Color.Spade, value: Value.Jack)

//print ("card1:", card1)
//print ("card2:", card2)
//print ("card3:", card3)
//print ("card4:", card4)
//print("\nTesting isEqual")
//print("card1 == card2 false:", card1.isEqual(card2))
//print("card1 == card3 true:", card1.isEqual(card3))
//print("card1 == card4 false:", card2.isEqual(card3))

//print("---------------------------------------------------------------------------------------------------------------")
//ex02

//class Deck : NSObject {
//    static let allSpades : [Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
//    static let allDiamonds : [Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
//    static let allHearts  : [Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
//    static let allClubs : [Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
//    static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs
//
//}

//print(Deck.oldArray)
//print(Deck.randomNum)
//print(Deck.allCards.count)
//print(Deck.allSpades)
//print(Deck.allHearts)
//print(Deck.allClubs)
//print(Deck.allDiamonds)
//print(Deck.allCards)

//print("ex03---------------------------------------------------------------------------------------------------------------")

//extension Array {
//    mutating func shuffle(){
//        for _ in 0..<(Deck.allCards.count) {
//            sort { (_,_) in arc4random_uniform(UInt32(Deck.allCards.count)) < arc4random_uniform(UInt32(Deck.allCards.count)) }
//        }
//    }
//}

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
    static let allHearts  : [Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
    static let allClubs : [Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
    static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs
    
    var cards: [Card] = []
    var discards: [Card] = []
    var outs: [Card] = []
    
    init(shuffled:Bool){
        self.cards = Deck.allCards
        if shuffled == true {
            self.cards.shuffle()
        }
    }
    
    override var description: String {
         return "(\(self.cards))"
    }
    
    func draw() -> Card? {
        var firstCard : Card?
        firstCard = self.cards.first
        if firstCard != nil {
            outs.append(firstCard!)
            cards.removeFirst()
            return firstCard
        } else {
            return nil
        }
    }
    
    func fold(c: Card) {
        if let find = outs.index(of: c) {
            outs.remove(at: find)
            discards.append(c)
        }
    }
}

extension Array {
    mutating func shuffle(){
        var elements = self
        var newArray : [Element] = [];
        for _ in elements {
            let j = Int(arc4random_uniform(UInt32(elements.count - 1)))
            newArray.append(elements[j])
            elements.remove(at: j)
        }
        self = newArray
    }
}



//var shufflecards = Deck.allCards
//shufflecards.shuffle()
//print(shufflecards)

//print("ex04---------------------------------------------------------------------------------------------------------------")











//let d1 = Deck(false)
//
//print(d1.description)

//print("Tacking a shuffled deck")
//var shufflecards = Deck(shuffled: true)
//print(shufflecards)
//
//print("Tacking a sorted deck")
//var sorted = Deck(shuffled: false)
//print("\n\n taking a sorted deck")
//print(sorted)
//print("\ndrawing first two card of a sorted deck")
//var draw = sorted.draw()
//draw = sorted.draw()
//print(sorted)
//print("**printing cards out:", sorted.outs)
//
//var shuffledeck0 = Deck(shuffled: true)
//print("\n\n taking a shuffledeck0 deck")
//print(shuffledeck0)
//print("\ndrawing first two card of a shuffledeck0 deck")
//draw = shuffledeck0.draw()
//draw = shuffledeck0.draw()
//print(shuffledeck0)
//print("printing cards out:", shuffledeck0.outs)
//
//var shuffleddeck = Deck(shuffled: true)
//print("\n\n taking a shuffled deck")
//print(shuffleddeck)
//print("\ndrawing all cards + 1 of a shuffled deck")
//for _ in shuffleddeck.cards {
//    draw = shuffleddeck.draw()
//}
//print(shuffleddeck)
//print("printing cards out:", shuffleddeck.outs)
//
//var shuffled2 = Deck(shuffled: true)
//print("\n\n taking a new shuffled deck\n\n", shuffled2)
//var handpicker = shuffled2.cards[1]
//print("\n\nhandpicking a card from a shuffled deck", handpicker)
//print("\ndrawing first two cards of a shuffled deck")
//draw = shuffled2.draw()
//draw = shuffled2.draw()
//print("cards out:", shuffled2.outs)
//print("cards discards:", shuffled2.discards)
//print("\nfolding selected cards:", handpicker)
//shuffled2.fold(c: handpicker)
//print("cards out:", shuffled2.outs)
//print("cards discards:", shuffled2.discards)











//
//let input = "25/03/2003"
//let formatter = DateFormatter()
//formatter.dateFormat = "MM/dd/yyyy"
//let date = formatter.date(from: input)




//let formatter = DateFormatter()
//formatter.dateFormat = "MM/dd/yyyy"
//if let date = formatter.date(from: input) {
//    print(date)  // Prints:  2018-12-10 06:00:00 +0000
//}
//let input = "12/10/2018"
let input = "2018-12-10T17:29:50Z"
//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let formatter = DateFormatter()
formatter.locale = Locale(identifier: "en_US_POSIX")
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
if let date = formatter.date(from: input) {
    print(date)
}















