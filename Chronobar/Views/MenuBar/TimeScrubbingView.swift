import SwiftUI

struct TimeScrubbingView: View {
    @EnvironmentObject var appState: AppState

    // Always operate in the base (starred) zone's timezone
    private var baseTZ: TimeZone {
        appState.baseZone.flatMap { TimeZone(identifier: $0.identifier) } ?? .current
    }

    private var baseCal: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = baseTZ
        return cal
    }

    private var minuteOfDay: Double {
        let comps = baseCal.dateComponents([.hour, .minute], from: appState.effectiveDate)
        return Double((comps.hour ?? 0) * 60 + (comps.minute ?? 0))
    }

    private func setMinuteOfDay(_ minutes: Double) {
        let baseDate = appState.isUsingNow ? Date() : appState.selectedDate
        appState.isUsingNow = false
        var comps = baseCal.dateComponents([.year, .month, .day], from: baseDate)
        comps.hour = Int(minutes) / 60
        comps.minute = Int(minutes) % 60
        comps.second = 0
        if let newDate = baseCal.date(from: comps) {
            appState.selectedDate = newDate
        }
    }

    private func setDate(_ newDate: Date) {
        let timeSource = appState.isUsingNow ? Date() : appState.selectedDate
        appState.isUsingNow = false
        let timeComps = baseCal.dateComponents([.hour, .minute, .second], from: timeSource)
        var dateComps = baseCal.dateComponents([.year, .month, .day], from: newDate)
        dateComps.hour = timeComps.hour
        dateComps.minute = timeComps.minute
        dateComps.second = timeComps.second
        if let combined = baseCal.date(from: dateComps) {
            appState.selectedDate = combined
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
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
                Spacer()
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
