import Foundation

struct CityTimeZone: Identifiable {
    let id = UUID()
    let label: String
    let identifier: String
}

enum CityTimeZoneMap {
    /// Curated list of major cities with their IANA timezone identifiers.
    /// Used to make the zone search human-friendly (search "Mumbai" → Asia/Kolkata).
    static let all: [CityTimeZone] = [
        CityTimeZone(label: "Abu Dhabi", identifier: "Asia/Dubai"),
        CityTimeZone(label: "Amsterdam", identifier: "Europe/Amsterdam"),
        CityTimeZone(label: "Athens", identifier: "Europe/Athens"),
        CityTimeZone(label: "Auckland", identifier: "Pacific/Auckland"),
        CityTimeZone(label: "Baghdad", identifier: "Asia/Baghdad"),
        CityTimeZone(label: "Bangalore", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Bangkok", identifier: "Asia/Bangkok"),
        CityTimeZone(label: "Beijing", identifier: "Asia/Shanghai"),
        CityTimeZone(label: "Berlin", identifier: "Europe/Berlin"),
        CityTimeZone(label: "Bogota", identifier: "America/Bogota"),
        CityTimeZone(label: "Brussels", identifier: "Europe/Brussels"),
        CityTimeZone(label: "Buenos Aires", identifier: "America/Argentina/Buenos_Aires"),
        CityTimeZone(label: "Cairo", identifier: "Africa/Cairo"),
        CityTimeZone(label: "Chennai", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Chicago", identifier: "America/Chicago"),
        CityTimeZone(label: "Colombo", identifier: "Asia/Colombo"),
        CityTimeZone(label: "Copenhagen", identifier: "Europe/Copenhagen"),
        CityTimeZone(label: "Dallas", identifier: "America/Chicago"),
        CityTimeZone(label: "Dhaka", identifier: "Asia/Dhaka"),
        CityTimeZone(label: "Dubai", identifier: "Asia/Dubai"),
        CityTimeZone(label: "Dublin", identifier: "Europe/Dublin"),
        CityTimeZone(label: "Frankfurt", identifier: "Europe/Berlin"),
        CityTimeZone(label: "Helsinki", identifier: "Europe/Helsinki"),
        CityTimeZone(label: "Hong Kong", identifier: "Asia/Hong_Kong"),
        CityTimeZone(label: "Houston", identifier: "America/Chicago"),
        CityTimeZone(label: "Hyderabad", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Istanbul", identifier: "Europe/Istanbul"),
        CityTimeZone(label: "Jakarta", identifier: "Asia/Jakarta"),
        CityTimeZone(label: "Johannesburg", identifier: "Africa/Johannesburg"),
        CityTimeZone(label: "Karachi", identifier: "Asia/Karachi"),
        CityTimeZone(label: "Kathmandu", identifier: "Asia/Kathmandu"),
        CityTimeZone(label: "Kolkata", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Kuala Lumpur", identifier: "Asia/Kuala_Lumpur"),
        CityTimeZone(label: "Kuwait City", identifier: "Asia/Kuwait"),
        CityTimeZone(label: "Lagos", identifier: "Africa/Lagos"),
        CityTimeZone(label: "Lahore", identifier: "Asia/Karachi"),
        CityTimeZone(label: "Lima", identifier: "America/Lima"),
        CityTimeZone(label: "Lisbon", identifier: "Europe/Lisbon"),
        CityTimeZone(label: "London", identifier: "Europe/London"),
        CityTimeZone(label: "Los Angeles", identifier: "America/Los_Angeles"),
        CityTimeZone(label: "Madrid", identifier: "Europe/Madrid"),
        CityTimeZone(label: "Manila", identifier: "Asia/Manila"),
        CityTimeZone(label: "Melbourne", identifier: "Australia/Melbourne"),
        CityTimeZone(label: "Mexico City", identifier: "America/Mexico_City"),
        CityTimeZone(label: "Miami", identifier: "America/New_York"),
        CityTimeZone(label: "Milan", identifier: "Europe/Rome"),
        CityTimeZone(label: "Moscow", identifier: "Europe/Moscow"),
        CityTimeZone(label: "Mumbai", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Nairobi", identifier: "Africa/Nairobi"),
        CityTimeZone(label: "New Delhi", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "New York", identifier: "America/New_York"),
        CityTimeZone(label: "Osaka", identifier: "Asia/Tokyo"),
        CityTimeZone(label: "Oslo", identifier: "Europe/Oslo"),
        CityTimeZone(label: "Paris", identifier: "Europe/Paris"),
        CityTimeZone(label: "Perth", identifier: "Australia/Perth"),
        CityTimeZone(label: "Pune", identifier: "Asia/Kolkata"),
        CityTimeZone(label: "Riyadh", identifier: "Asia/Riyadh"),
        CityTimeZone(label: "Rome", identifier: "Europe/Rome"),
        CityTimeZone(label: "San Francisco", identifier: "America/Los_Angeles"),
        CityTimeZone(label: "Santiago", identifier: "America/Santiago"),
        CityTimeZone(label: "Sao Paulo", identifier: "America/Sao_Paulo"),
        CityTimeZone(label: "Seattle", identifier: "America/Los_Angeles"),
        CityTimeZone(label: "Seoul", identifier: "Asia/Seoul"),
        CityTimeZone(label: "Shanghai", identifier: "Asia/Shanghai"),
        CityTimeZone(label: "Singapore", identifier: "Asia/Singapore"),
        CityTimeZone(label: "Stockholm", identifier: "Europe/Stockholm"),
        CityTimeZone(label: "Sydney", identifier: "Australia/Sydney"),
        CityTimeZone(label: "Taipei", identifier: "Asia/Taipei"),
        CityTimeZone(label: "Tehran", identifier: "Asia/Tehran"),
        CityTimeZone(label: "Tel Aviv", identifier: "Asia/Jerusalem"),
        CityTimeZone(label: "Tokyo", identifier: "Asia/Tokyo"),
        CityTimeZone(label: "Toronto", identifier: "America/Toronto"),
        CityTimeZone(label: "Vancouver", identifier: "America/Vancouver"),
        CityTimeZone(label: "Vienna", identifier: "Europe/Vienna"),
        CityTimeZone(label: "Warsaw", identifier: "Europe/Warsaw"),
        CityTimeZone(label: "Washington DC", identifier: "America/New_York"),
        CityTimeZone(label: "Zurich", identifier: "Europe/Zurich"),
    ]

    static func search(_ query: String) -> [CityTimeZone] {
        guard !query.isEmpty else { return all }
        return all.filter {
            $0.label.localizedCaseInsensitiveContains(query) ||
            $0.identifier.localizedCaseInsensitiveContains(query)
        }
    }
}
