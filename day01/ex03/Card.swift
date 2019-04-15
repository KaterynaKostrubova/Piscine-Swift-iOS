import Foundation

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
