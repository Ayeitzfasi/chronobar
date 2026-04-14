import SwiftUI

@main
struct ChronobarApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra {
            MenuBarContentView()
                .environmentObject(appState)
        } label: {
            Label(appState.menuBarTitle, systemImage: "clock.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
