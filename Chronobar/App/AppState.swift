import Foundation
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var savedZones: [SavedTimeZone] = []
    @Published var selectedDate: Date = Date()
    @Published var isUsingNow: Bool = true

    private let persistence = PersistenceService()
    private var timer: AnyCancellable?
    private var settingsWindow: NSWindow?

    var effectiveDate: Date {
        isUsingNow ? Date() : selectedDate
    }

    var baseZone: SavedTimeZone? {
        savedZones.first(where: { $0.isBaseZone }) ?? savedZones.first
    }

    var menuBarTitle: String {
        guard let base = baseZone,
              let tz = TimeZone(identifier: base.identifier) else { return "TZ" }
        return tz.abbreviation() ?? String(base.label.prefix(3)).uppercased()
    }

    var conversionResults: [TimeConversionResult] {
        TimeZoneService.convert(date: effectiveDate, zones: savedZones)
    }

    init() {
        savedZones = persistence.loadZones()
        if savedZones.isEmpty {
            savedZones = SavedTimeZone.defaults
            persistence.saveZones(savedZones)
        }
        startTimer()
    }

    private func startTimer() {
        timer = Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self, self.isUsingNow else { return }
                self.objectWillChange.send()
            }
    }

    func resetToNow() {
        selectedDate = Date()
        isUsingNow = true
    }

    func openSettings() {
        if let window = settingsWindow, window.isVisible {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        let view = SettingsView().environmentObject(self)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 380, height: 460),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Chronobar Settings"
        window.contentView = NSHostingView(rootView: view)
        window.isReleasedWhenClosed = false
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        settingsWindow = window
    }

    func saveZones() {
        persistence.saveZones(savedZones)
    }

    // MARK: - Zone Management

    func addZone(identifier: String, label: String? = nil) {
        let resolvedLabel = label ?? identifier.components(separatedBy: "/").last?
            .replacingOccurrences(of: "_", with: " ") ?? identifier
        // Allow multiple entries for same identifier with different city labels (e.g. Mumbai + Hyderabad both = Asia/Kolkata)
        guard !savedZones.contains(where: { $0.identifier == identifier && $0.label == resolvedLabel }) else { return }
        let nextOrder = (savedZones.map(\.sortOrder).max() ?? -1) + 1
        savedZones.append(SavedTimeZone(label: resolvedLabel, identifier: identifier, sortOrder: nextOrder))
        saveZones()
    }

    func removeZones(at offsets: IndexSet) {
        let sorted = savedZones.sorted { $0.sortOrder < $1.sortOrder }
        let ids = offsets.map { sorted[$0].id }
        savedZones.removeAll { ids.contains($0.id) }
        reindexZones()
        saveZones()
    }

    func moveZones(from source: IndexSet, to destination: Int) {
        var sorted = savedZones.sorted { $0.sortOrder < $1.sortOrder }
        sorted.move(fromOffsets: source, toOffset: destination)
        for (i, zone) in sorted.enumerated() {
            if let idx = savedZones.firstIndex(where: { $0.id == zone.id }) {
                savedZones[idx].sortOrder = i
            }
        }
        saveZones()
    }

    func setBaseZone(_ zone: SavedTimeZone) {
        for i in savedZones.indices {
            savedZones[i].isBaseZone = savedZones[i].id == zone.id
        }
        saveZones()
    }

    func updateLabel(_ zone: SavedTimeZone, label: String) {
        guard let idx = savedZones.firstIndex(where: { $0.id == zone.id }) else { return }
        savedZones[idx].label = label.isEmpty ? zone.label : label
        saveZones()
    }

    private func reindexZones() {
        let sorted = savedZones.sorted { $0.sortOrder < $1.sortOrder }
        for (i, zone) in sorted.enumerated() {
            if let idx = savedZones.firstIndex(where: { $0.id == zone.id }) {
                savedZones[idx].sortOrder = i
            }
        }
    }
}
