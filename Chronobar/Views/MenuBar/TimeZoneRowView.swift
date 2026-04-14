import SwiftUI

struct TimeZoneRowView: View {
    @EnvironmentObject var appState: AppState
    let result: TimeConversionResult

    @FocusState private var isEditing: Bool
    @State private var inputText: String = ""

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 5) {
                    Text(result.zone.label)
                        .font(.system(size: 13, weight: .semibold))
                    if result.zone.isBaseZone {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 5))
                            .foregroundStyle(.blue)
                    }
                }
                Text(result.formattedDate)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                // Tap the time to type a new value — all zones update from this zone's time
                TextField(
                    "",
                    text: Binding(
                        get: { isEditing ? inputText : result.formattedTime },
                        set: { inputText = $0 }
                    )
                )
                .focused($isEditing)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.plain)
                .frame(width: 95)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isEditing ? Color.accentColor.opacity(0.12) : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(isEditing ? Color.accentColor.opacity(0.5) : Color.clear, lineWidth: 1)
                        )
                )
                .onSubmit {
                    applyTypedTime()
                    isEditing = false
                }
                .onChange(of: isEditing) { focused in
                    if focused {
                        inputText = result.formattedTime
                    }
                }

                DayOffsetBadge(dayOffset: result.dayOffset)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 9)
        .contentShape(Rectangle())
    }

    // Parse the typed time (in this row's timezone) and update the global selectedDate
    private func applyTypedTime() {
        guard let tz = TimeZone(identifier: result.zone.identifier) else { return }
        let trimmed = inputText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        let formats = ["h:mm a", "h:mma", "H:mm", "ha", "h a", "h:mm", "H"]
        let locale = Locale(identifier: "en_US_POSIX")

        for format in formats {
            let f = DateFormatter()
            f.dateFormat = format
            f.locale = locale
            f.timeZone = tz
            if let parsed = f.date(from: trimmed) {
                var zoneCal = Calendar(identifier: .gregorian)
                zoneCal.timeZone = tz

                // Preserve the current date, apply the typed time in this zone
                let timeComps = zoneCal.dateComponents([.hour, .minute], from: parsed)
                var dateComps = zoneCal.dateComponents([.year, .month, .day], from: appState.effectiveDate)
                dateComps.hour = timeComps.hour
                dateComps.minute = timeComps.minute
                dateComps.second = 0

                if let newDate = zoneCal.date(from: dateComps) {
                    appState.selectedDate = newDate
                    appState.isUsingNow = false
                }
                return
            }
        }
        // Parse failed — field reverts to current time on next render
    }
}
