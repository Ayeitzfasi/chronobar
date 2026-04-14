import Foundation

struct SavedTimeZone: Identifiable, Codable, Equatable {
    let id: UUID
    var label: String
    var identifier: String  // IANA timezone identifier, e.g. "Asia/Dubai"
    var sortOrder: Int
    var isBaseZone: Bool

    init(id: UUID = UUID(), label: String, identifier: String, sortOrder: Int, isBaseZone: Bool = false) {
        self.id = id
        self.label = label
        self.identifier = identifier
        self.sortOrder = sortOrder
        self.isBaseZone = isBaseZone
    }

    static let defaults: [SavedTimeZone] = [
        SavedTimeZone(label: "Dubai", identifier: "Asia/Dubai", sortOrder: 0, isBaseZone: true),
        SavedTimeZone(label: "London", identifier: "Europe/London", sortOrder: 1),
        SavedTimeZone(label: "Toronto", identifier: "America/Toronto", sortOrder: 2)
    ]
}
