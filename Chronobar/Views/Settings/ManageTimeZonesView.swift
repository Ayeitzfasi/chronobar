import SwiftUI

struct ManageTimeZonesView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var viewModel: SettingsViewModel
    @State private var isAddingZone = false

    private var sortedZones: [SavedTimeZone] {
        appState.savedZones.sorted { $0.sortOrder < $1.sortOrder }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Time Zones")
                    .font(.headline)
                Spacer()
                Button {
                    isAddingZone.toggle()
                } label: {
                    Image(systemName: isAddingZone ? "minus.circle.fill" : "plus.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(isAddingZone ? Color.secondary : Color.blue)
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 8)

            Divider()

            List {
                ForEach(sortedZones) { zone in
                    ZoneRowEditView(zone: zone)
                        .environmentObject(appState)
                }
                .onMove { appState.moveZones(from: $0, to: $1) }
            }
            .listStyle(.plain)
            .frame(minHeight: 200)

            if isAddingZone {
                Divider()
                AddZoneView(isPresented: $isAddingZone)
                    .environmentObject(appState)
                    .environmentObject(viewModel)
            }
        }
    }
}

// MARK: - Zone Row (edit mode)

struct ZoneRowEditView: View {
    @EnvironmentObject var appState: AppState
    let zone: SavedTimeZone
    @State private var editingLabel: String = ""
    @State private var isEditing = false

    var body: some View {
        HStack(spacing: 10) {
            Button {
                appState.setBaseZone(zone)
            } label: {
                Image(systemName: zone.isBaseZone ? "star.fill" : "star")
                    .foregroundStyle(zone.isBaseZone ? .yellow : .secondary)
                    .font(.system(size: 13))
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                if isEditing {
                    TextField("Label", text: $editingLabel)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 13))
                        .onSubmit {
                            appState.updateLabel(zone, label: editingLabel)
                            isEditing = false
                        }
                } else {
                    Text(zone.label)
                        .font(.system(size: 13, weight: .medium))
                }
                Text(zone.identifier)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                if isEditing {
                    appState.updateLabel(zone, label: editingLabel)
                    isEditing = false
                } else {
                    editingLabel = zone.label
                    isEditing = true
                }
            } label: {
                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                    .font(.system(size: 13))
                    .foregroundStyle(isEditing ? Color.blue : Color.secondary)
            }
            .buttonStyle(.plain)

            Button {
                if let idx = appState.savedZones.firstIndex(where: { $0.id == zone.id }) {
                    appState.removeZones(at: IndexSet([idx]))
                }
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.red.opacity(0.7))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Add Zone Search

struct AddZoneView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var viewModel: SettingsViewModel
    @Binding var isPresented: Bool

    private var filtered: [String] {
        let all = TimeZone.knownTimeZoneIdentifiers.sorted()
        guard !viewModel.searchText.isEmpty else { return all }
        return all.filter { $0.localizedCaseInsensitiveContains(viewModel.searchText) }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 13))
                TextField("Search time zones...", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 13))
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(10)

            Divider()

            List(Array(filtered.prefix(60)), id: \.self) { identifier in
                Button {
                    appState.addZone(identifier: identifier)
                    isPresented = false
                    viewModel.searchText = ""
                } label: {
                    HStack {
                        Text(identifier)
                            .font(.system(size: 12))
                            .foregroundStyle(.primary)
                        Spacer()
                        if appState.savedZones.contains(where: { $0.identifier == identifier }) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11))
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
            .frame(height: 140)
        }
    }
}
