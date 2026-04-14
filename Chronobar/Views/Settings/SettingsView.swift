import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ManageTimeZonesView()
                .environmentObject(appState)
                .environmentObject(viewModel)

            Divider()

            HStack {
                Toggle(
                    "Launch at Login",
                    isOn: Binding(
                        get: { viewModel.launchAtLogin },
                        set: { viewModel.toggleLaunchAtLogin($0) }
                    )
                )
                Spacer()
            }
            .padding()
        }
        .frame(width: 380, height: 460)
    }
}
