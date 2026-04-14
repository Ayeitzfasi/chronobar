import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "clock.badge.questionmark")
                .font(.system(size: 32))
                .foregroundStyle(.secondary)
            Text("No time zones added")
                .font(.headline)
            Text("Open Settings to add time zones")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 28)
        .frame(maxWidth: .infinity)
    }
}
