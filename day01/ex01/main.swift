
let card1 = Card(color: Color.Heart, value : Value.Seven)
let card2 = Card(color: Color.Diamond, value: Value.Ace)
let card3 = Card(color: Color.Heart, value : Value.Seven)
let card4 = Card(color: Color.Spade, value: Value.Jack)

print ("card1:", card1)
print ("card2:", card2)
print ("card3:", card3)
print ("card4:", card4)
print("\nTesting isEqual")
print("card1 == card2 false:", card1.isEqual(card2))
print("card1 == card3 true:", card1.isEqual(card3))
print("card1 == card4 false:", card2.isEqual(card3))
