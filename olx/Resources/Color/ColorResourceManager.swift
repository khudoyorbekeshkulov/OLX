import UIKit

class ColorResourceManager {
    static let shared = ColorResourceManager()
    private init() {}
    
    func color(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
            UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        }
    
    let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
}
