//
//  SettingsView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("showReminders") private var showReminders: Bool = false
    @AppStorage("reminderTime") private var reminderTime: Date = Date()
    @AppStorage("showIntention") private var showIntention: Bool = true
    @AppStorage("darkMode") private var darkMode: Bool = true

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Profile Info
                Section(header: Text("Profile")) {
                    Text("Username: StephDugas") // This can be made dynamic later
                }

                // MARK: - Study Reminders
                Section(header: Text("Reminders")) {
                    Toggle("Enable Study Reminders", isOn: $showReminders)

                    if showReminders {
                        DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    }
                }

                // MARK: - Preferences
                Section(header: Text("Preferences")) {
                    Toggle("Show Intention Screen", isOn: $showIntention)
                    Toggle("Dark Mode", isOn: $darkMode)
                }

                // MARK: - Premium Area
                Section(header: Text("Stacked Pro")) {
                    NavigationLink("Go Premium") {
                        Text("Premium coming soon!") // Placeholder
                    }

                    VStack(alignment: .leading) {
                        Text("• Remove ads")
                        Text("• Share stacks")
                        Text("• AI-powered flashcard creation")
                        Text("• Access pre-made templates")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)

                    Button("Restore Purchases") {
                        // Add logic later
                    }
                }

                // MARK: - App Info
                Section(header: Text("About")) {
                    Text("Version 1.0.0")
                    Link("Privacy Policy", destination: URL(string: "https://yourprivacypolicy.com")!)
                    Link("Terms of Service", destination: URL(string: "https://yourtermsofservice.com")!)
                }

                // MARK: - Danger Zone
                Section {
                    Button(role: .destructive) {
                        // Add reset logic
                    } label: {
                        Text("Reset All Stacks")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
