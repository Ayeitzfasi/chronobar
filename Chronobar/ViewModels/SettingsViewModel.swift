import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var launchAtLogin: Bool = LaunchAtLoginService.isEnabled

    func toggleLaunchAtLogin(_ enabled: Bool) {
        LaunchAtLoginService.setEnabled(enabled)
        launchAtLogin = LaunchAtLoginService.isEnabled
    }
}
