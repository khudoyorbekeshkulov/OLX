import UIKit

extension UIColor {
    private static let colors: [String: UIColor] = [
        "white":       .white,
        "yellow":      UIColor(red: 255/255, green: 206/255, blue: 50/255,  alpha: 1),
        "lightGreen":  UIColor(red: 235/255, green: 250/255, blue: 240/255, alpha: 1),
        "lightYellow": UIColor(red: 253/255, green: 246/255, blue: 222/255, alpha: 1),
        "lightGray":   UIColor(red: 240/255, green: 247/255, blue: 247/255, alpha: 1),
        "lightBlue":   UIColor(red: 225/255, green: 240/255, blue: 255/255, alpha: 1),
        "lightOrange": UIColor(red: 255/255, green: 243/255, blue: 230/255, alpha: 1),
        "lightPurple": UIColor(red: 243/255, green: 235/255, blue: 255/255, alpha: 1),
        "darkGray":    UIColor(red: 79/255,  green: 79/255,  blue: 79/255,  alpha: 1)
    ]
    
    static func named(_ name: String) -> UIColor? {
        colors[name]
    }
}
