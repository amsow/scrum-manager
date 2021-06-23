//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
  @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
          NavigationView {
            ScrumsListView(scrums: $scrums)
          }
        }
    }
}
