import Foundation

struct TimeConversionResult: Identifiable {
    let id = UUID()
    let zone: SavedTimeZone
    let convertedDate: Date
    let formattedTime: String
    let formattedDate: String
    // Relative to the base zone's day: -1 = yesterday, 0 = same day, 1 = tomorrow
    let dayOffset: Int

    var dayLabel: String {
        switch dayOffset {
        case -1: return "Yesterday"
        case 0:  return "Today"
        case 1:  return "Tomorrow"
        default: return dayOffset > 0 ? "+\(dayOffset)d" : "\(dayOffset)d"
        }
    }
}
