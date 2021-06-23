//
//  ScrumListView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct ScrumsListView: View {
  @Binding var scrums: [DailyScrum]
  
  var body: some View {
    List {
      ForEach(scrums) { scrum in
        NavigationLink(destination: ScrumDetailView(scrum: binding(for: scrum))) {
          CardView(scrum: scrum)
        }
        .listRowBackground(scrum.color)
      }
    }
    .navigationTitle("Daily Scrums")
    .navigationBarItems(trailing: Button(action: { }) {
      Image(systemName: "plus")
    })
  }
  
  private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
    guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
      fatalError("Can't find scrum in array")
    }
    return $scrums[scrumIndex]
  }
}

struct ScrumListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScrumsListView(scrums: .constant(DailyScrum.data))
    }
    .environment(\.colorScheme, .dark)
  }
}






struct ContentView: View {
  enum Flavor: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case vanilla, chocolate, strawberry
  }
  
  var body: some View {
    List {
      ForEach(Flavor.allCases) {
        Text($0.rawValue)
          .listRowBackground(Ellipse()
                              .background(Color.clear)
                              .foregroundColor(.purple)
                              .opacity(0.3)
          )
      }
    }
  }
}
