import SwiftUI

struct TimeZoneRowView: View {
    let result: TimeConversionResult

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
                Text(result.formattedTime)
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                DayOffsetBadge(dayOffset: result.dayOffset)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 9)
    }
}
