import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("Chronobar")
                    .font(.system(size: 13, weight: .bold))
                HStack(spacing: 5) {
                    Circle()
                        .fill(appState.isUsingNow ? Color.green : Color.orange)
                        .frame(width: 6, height: 6)
                    Text(appState.isUsingNow ? "Live" : "Custom time")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if !appState.isUsingNow {
                Button("Reset to Now") {
                    appState.resetToNow()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
}
