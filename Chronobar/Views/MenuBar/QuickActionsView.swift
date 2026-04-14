import SwiftUI
import AppKit

struct QuickActionsView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        HStack {
            actionButton(icon: "doc.on.doc", label: "Copy") {
                copyAllTimes()
            }
            .frame(maxWidth: .infinity)

            actionButton(icon: "clock.arrow.circlepath", label: "Now") {
                appState.resetToNow()
            }
            .foregroundStyle(appState.isUsingNow ? Color.secondary : Color.orange)
            .frame(maxWidth: .infinity)

            actionButton(icon: "gear", label: "Settings") {
                appState.openSettings()
            }
            .frame(maxWidth: .infinity)

            actionButton(icon: "power", label: "Quit") {
                NSApplication.shared.terminate(nil)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func actionButton(icon: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Image(systemName: icon)
                    .font(.system(size: 13))
                Text(label)
                    .font(.system(size: 10))
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(.secondary)
    }

    private func copyAllTimes() {
        let lines = appState.conversionResults.map { result in
            "\(result.zone.label): \(result.formattedTime) (\(result.dayLabel))"
        }.joined(separator: "\n")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(lines, forType: .string)
    }
}
