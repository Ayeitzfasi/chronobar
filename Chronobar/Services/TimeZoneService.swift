import Foundation

enum TimeZoneService {
    static func convert(date: Date, zones: [SavedTimeZone]) -> [TimeConversionResult] {
        let sorted = zones.sorted { $0.sortOrder < $1.sortOrder }

        // Base zone used as the reference day for offset calculation
        let baseZone = sorted.first(where: { $0.isBaseZone }) ?? sorted.first
        let baseTZ = baseZone.flatMap { TimeZone(identifier: $0.identifier) } ?? .current

        var baseCal = Calendar(identifier: .gregorian)
        baseCal.timeZone = baseTZ

        // Use UTC noon as a neutral anchor to compare calendar dates without
        // timestamp arithmetic skewing the result (e.g. a 20-hour gap that
        // spans two calendar days should still count as 1 day offset)
        var utcCal = Calendar(identifier: .gregorian)
        utcCal.timeZone = TimeZone(secondsFromGMT: 0)!

        let baseDay = baseCal.dateComponents([.year, .month, .day], from: date)
        guard let baseNoon = utcCal.date(from: DateComponents(
            year: baseDay.year, month: baseDay.month, day: baseDay.day, hour: 12
        )) else { return [] }

        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"

        return sorted.compactMap { zone in
            guard let tz = TimeZone(identifier: zone.identifier) else { return nil }

            var targetCal = Calendar(identifier: .gregorian)
            targetCal.timeZone = tz

            // Get the calendar date in the target timezone and anchor to UTC noon
            let targetDay = targetCal.dateComponents([.year, .month, .day], from: date)
            guard let targetNoon = utcCal.date(from: DateComponents(
                year: targetDay.year, month: targetDay.month, day: targetDay.day, hour: 12
            )) else { return nil }

            // Compare calendar days, not timestamps
            let dayOffset = utcCal.dateComponents([.day], from: baseNoon, to: targetNoon).day ?? 0

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
