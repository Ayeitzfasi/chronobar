import Foundation

class PersistenceService {
    private let zonesKey = "chronobar.savedZones"

    func loadZones() -> [SavedTimeZone] {
        guard let data = UserDefaults.standard.data(forKey: zonesKey),
              let zones = try? JSONDecoder().decode([SavedTimeZone].self, from: data)
        else { return [] }
        return zones
    }

    func saveZones(_ zones: [SavedTimeZone]) {
        guard let data = try? JSONEncoder().encode(zones) else { return }
        UserDefaults.standard.set(data, forKey: zonesKey)
    }
}
