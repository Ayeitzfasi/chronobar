import SwiftUI

struct DayOffsetBadge: View {
    let dayOffset: Int

    private var color: Color {
        switch dayOffset {
        case 0:  return .secondary
        case 1...: return .blue
        default: return .orange
        }
    }

    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .medium))
            .foregroundStyle(dayOffset == 0 ? Color.secondary : color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(dayOffset == 0 ? Color.secondary.opacity(0.1) : color.opacity(0.15))
            )
    }

    private var label: String {
        switch dayOffset {
        case -1: return "Yesterday"
        case 0:  return "Today"
        case 1:  return "Tomorrow"
        default: return dayOffset > 0 ? "+\(dayOffset)d" : "\(dayOffset)d"
        }
    }
}
