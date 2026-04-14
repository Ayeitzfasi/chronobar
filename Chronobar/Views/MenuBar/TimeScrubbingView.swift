import SwiftUI

struct TimeScrubbingView: View {
    @EnvironmentObject var appState: AppState

    private var minuteOfDay: Double {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: appState.effectiveDate)
        return Double((comps.hour ?? 0) * 60 + (comps.minute ?? 0))
    }

    private func setMinuteOfDay(_ minutes: Double) {
        let baseDate = appState.isUsingNow ? Date() : appState.selectedDate
        appState.isUsingNow = false
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: baseDate)
        comps.hour = Int(minutes) / 60
        comps.minute = Int(minutes) % 60
        comps.second = 0
        if let newDate = Calendar.current.date(from: comps) {
            appState.selectedDate = newDate
        }
    }

    private func setDate(_ newDate: Date) {
        let timeSource = appState.isUsingNow ? Date() : appState.selectedDate
        appState.isUsingNow = false
        let timeComps = Calendar.current.dateComponents([.hour, .minute, .second], from: timeSource)
        var dateComps = Calendar.current.dateComponents([.year, .month, .day], from: newDate)
        dateComps.hour = timeComps.hour
        dateComps.minute = timeComps.minute
        dateComps.second = timeComps.second
        if let combined = Calendar.current.date(from: dateComps) {
            appState.selectedDate = combined
        }
    }

    private func formatMinuteOfDay(_ minutes: Double) -> String {
        let h = Int(minutes) / 60
        let m = Int(minutes) % 60
        let period = h < 12 ? "AM" : "PM"
        let displayH = h == 0 ? 12 : (h > 12 ? h - 12 : h)
        return String(format: "%d:%02d %@", displayH, m, period)
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(formatMinuteOfDay(minuteOfDay))
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundStyle(appState.isUsingNow ? Color.secondary : Color.primary)
                Spacer()
                DatePicker(
                    "",
                    selection: Binding(
                        get: { appState.effectiveDate },
                        set: { setDate($0) }
                    ),
                    displayedComponents: .date
                )
                .labelsHidden()
                .datePickerStyle(.compact)
            }

            Slider(
                value: Binding(
                    get: { minuteOfDay },
                    set: { setMinuteOfDay($0) }
                ),
                in: 0...1439,
                step: 15
            )
            .tint(.blue)

            HStack {
                ForEach(["12AM", "6AM", "12PM", "6PM", "11PM"], id: \.self) { marker in
                    Text(marker)
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                    if marker != "11PM" { Spacer() }
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
}
