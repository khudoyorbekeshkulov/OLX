import UIKit

final class ColorResourceManager {
    static let shared = ColorResourceManager()
    private init() {}

    // MARK: - Backgrounds
    var appBackground: UIColor { color(.appBackground) }
    var cardBackground: UIColor { color(.cardBackground) }
    var chatBackground: UIColor { color(.chatBackground) }
    var profileBackground: UIColor { color(.profileBackground) }
    var searchBackground: UIColor { color(.searchBackground) }

    // MARK: - Chat
    var currentUserMessage: UIColor { color(.currentUserMessage) }
    var secondUserMessage: UIColor { color(.secondUserMessage) }

    // MARK: - Text
    var primaryText: UIColor { color(.primaryText) }
    var secondaryText: UIColor { color(.secondaryText) }
    var blackText: UIColor { color(.textBlack)}

    // MARK: - Brand / accents
    var mainManager: UIColor { color(.mainManager) }
    var darkMainManager: UIColor { color(.darkMainManager) }
    var heart: UIColor { color(.heart) }
    var magnifyingGlass: UIColor { color(.magnifyingGlass) }

    // MARK: - Controls
    var segmentedControl: UIColor { color(.segmentedControl) }
    var separator: UIColor { color(.separator) }
}

// MARK: - Asset names
private extension ColorResourceManager {

    /// Raw values must match the color set names in Assets.xcassets/Colors exactly.
    enum Name: String {
        case appBackground      = "app_background_color"
        case cardBackground     = "card_background_color"
        case chatBackground     = "chat_background_color"
        case currentUserMessage = "current_user_message_color"   // verify full name in assets
        case darkMainManager    = "dark_main_manager_color"      // verify full name in assets
        case heart              = "heart_color"
        case magnifyingGlass    = "magnifying_glass_color"
        case mainManager        = "main_manager_color"
        case primaryText        = "primary_text_color"
        case textBlack          = "primary_text_black_color"
        case profileBackground  = "profile_background_color"
        case searchBackground   = "search_background_color"      // verify full name in assets
        case secondUserMessage  = "second_user_message_color"    // verify full name in assets
        case secondaryText      = "secondary_text_color"
        case segmentedControl   = "segmented_control_color"
        case separator          = "separator_color"
    }

    func color(_ name: Name) -> UIColor {
        guard let color = UIColor(named: name.rawValue) else {
            assertionFailure("Missing color asset: \(name.rawValue)")
            return .magenta // obvious fallback so a typo is easy to spot
        }
        return color
    }
}
