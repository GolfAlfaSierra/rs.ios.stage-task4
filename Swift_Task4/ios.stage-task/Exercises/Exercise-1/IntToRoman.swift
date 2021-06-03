import Foundation

public extension Int {
    
    

    
    var roman: String? {
        
//        let romanSymbols = ["I","IV","V","IX","X","XL","L","XC","C","CD","D","CM","M"]
//        let romanNumbers = [1,4,5,9,10,40,50,90,100,400,500,900,1000]
        
        if ( self <= 0 ) {
            return nil
        }
        
        let M = ["", "M", "MM", "MMM"]
        let C = ["", "C", "CC", "CCC", "CD", "D",
                 "DC", "DCC", "DCCC", "CM"]
        let X = ["", "X", "XX", "XXX", "XL", "L",
                 "LX", "LXX", "LXXX", "XC"]
        let I = ["", "I", "II", "III", "IV", "V",
                 "VI", "VII", "VIII", "IX"]
        
        let thousands = M[self / 1000]
        let hundreds = C[(self % 1000) / 100]
        let tens = X[(self % 100) / 10]
        let ones = I[self % 10]
        
        
        
        let result = thousands + hundreds + tens + ones
        
        
        return result
    }
}
