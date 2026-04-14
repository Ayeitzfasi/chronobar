import SwiftUI

struct MenuBarContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            HeaderView()

            Divider()

            if appState.savedZones.isEmpty {
                EmptyStateView()
            } else {
                let results = appState.conversionResults
                ForEach(Array(results.enumerated()), id: \.element.id) { index, result in
                    TimeZoneRowView(result: result)
                    if index < results.count - 1 {
                        Divider()
                            .padding(.horizontal, 14)
                    }
                }
            }

            Divider()

            TimeScrubbingView()

            Divider()

            QuickActionsView()
        }
        .frame(width: 300)
    }
}
