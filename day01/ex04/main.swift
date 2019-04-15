
var shufflecards = Deck(shuffled: true)
print("Shuffled cards: \n", shufflecards)

var notshuffled = Deck(shuffled: false)
print("Not shuffled cards:\n", notshuffled)

var draw = notshuffled.draw()
print("Draw first card:", draw!)

draw = notshuffled.draw()
print("Draw second card:", draw!)

print("Deck after draw:\n", notshuffled)
print("Cards out:", notshuffled.outs)

print("Shuffled cards: \n", shufflecards)
draw = shufflecards.draw()
print("Draw first card:", draw!)

draw = shufflecards.draw()
print("Draw second card:", draw!)

print("Deck after draw:\n", shufflecards)
print("Cards out:", shufflecards.outs)

var shufflecards2 = Deck(shuffled: true)
print("Shuffled2 cards: \n", shufflecards2)
var hand = shufflecards2.cards[1]
print("hand", hand)
draw = shufflecards2.draw()
draw = shufflecards2.draw()
print("cards out:", shufflecards2.outs)
print("cards discards:", shufflecards2.discards)
shufflecards2.fold(c: hand)
print("cards out:", shufflecards2.outs)
print("cards discards:", shufflecards2.discards)
