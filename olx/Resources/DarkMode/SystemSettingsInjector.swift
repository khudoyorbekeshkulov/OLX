import Foundation

protocol SystemModeSetable {
    var mode: SystemSettingsThemeMode { get set }

    func set(mode: SystemSettingsThemeMode)
}

final class SystemSettingsInjector: SystemModeSetable {
    static let shared = SystemSettingsInjector()
    private init() {}
    
    var mode: SystemSettingsThemeMode = .light
    
    func set(mode: SystemSettingsThemeMode) {
        self.mode = mode
    }
}

class Kachokbek {
    let sharedInstance = SystemSettingsInjector.shared
    
    func hello() {
        
    }
}
