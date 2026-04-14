import Foundation

enum TimeZoneService {
    static func convert(date: Date, zones: [SavedTimeZone]) -> [TimeConversionResult] {
        let sorted = zones.sorted { $0.sortOrder < $1.sortOrder }

        // Base zone used as the reference day for offset calculation
        let baseZone = sorted.first(where: { $0.isBaseZone }) ?? sorted.first
        let baseTZ = baseZone.flatMap { TimeZone(identifier: $0.identifier) } ?? .current

        var baseCal = Calendar(identifier: .gregorian)
        baseCal.timeZone = baseTZ
        let baseDayStart = baseCal.startOfDay(for: date)

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"

        return sorted.compactMap { zone in
            guard let tz = TimeZone(identifier: zone.identifier) else { return nil }

            var targetCal = Calendar(identifier: .gregorian)
            targetCal.timeZone = tz

            let targetDayStart = targetCal.startOfDay(for: date)
            let dayOffset = baseCal.dateComponents([.day], from: baseDayStart, to: targetDayStart).day ?? 0

            timeFormatter.timeZone = tz
            dateFormatter.timeZone = tz

            return TimeConversionResult(
                zone: zone,
                convertedDate: date,
                formattedTime: timeFormatter.string(from: date),
                formattedDate: dateFormatter.string(from: date),
                dayOffset: dayOffset
            )
        }
    }
}
