//
//  SettingsView.swift
//  Stacked
//
//  Created by Stephanie Dugas on 4/8/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: FlashcardViewModel

    @AppStorage("showReminders") private var showReminders: Bool = false
    @AppStorage("reminderTime") private var reminderTime: Date = Date()
    @AppStorage("showIntention") private var showIntention: Bool = true
    

    @State private var showingResetAlert = false

    // Pull app version dynamically from Info.plist
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Profile Info
                Section(header: Text("Profile")) {
                    Text("Username: StephDugas") // Static for now
                }

                // MARK: - Study Reminders
                Section(header: Text("Reminders")) {
                    Toggle("Enable Study Reminders", isOn: $showReminders)

                    if showReminders {
                        DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    }
                }

                
                // MARK: - Premium
                Section(header: Text("Stacked Pro")) {
                    NavigationLink("Go Premium") {
                        Text("Premium coming soon!")
                            .padding()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Remove ads")
                        Text("• Share stacks")
                        Text("• AI-powered flashcard creation")
                        Text("• Access pre-made templates")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)

                    Button("Restore Purchases") {
                        // StoreKit restore logic goes here
                    }
                }

                // MARK: - App Info
                Section(header: Text("About")) {
                    Text("Version \(appVersion)")
                    Link("Privacy Policy", destination: URL(string: "https://yourprivacypolicy.com")!)
                    Link("Terms of Service", destination: URL(string: "https://yourtermsofservice.com")!)
                }

                // MARK: - Danger Zone
                Section {
                    Button(role: .destructive) {
                        showingResetAlert = true
                    } label: {
                        Text("Reset All Stacks")
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Are you sure?", isPresented: $showingResetAlert) {
                Button("Delete All Stacks", role: .destructive) {
                    viewModel.resetAllStacks()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will permanently delete all your stacks and flashcards.")
            }
        }
        // Notifications when user changes reminder toggle or time
        .onChange(of: showReminders) { enabled in
            if enabled {
                NotificationManager.shared.requestPermission()
                NotificationManager.shared.scheduleDailyReminder(at: reminderTime)
            } else {
                NotificationManager.shared.cancelReminder()
            }
        }
        .onChange(of: reminderTime) { newTime in
            if showReminders {
                NotificationManager.shared.scheduleDailyReminder(at: newTime)
            }
        }
    }
}
