//
//  ScrumListView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct ScrumsListView: View {
  @Binding var scrums: [DailyScrum]
  @State var isPresented: Bool = false
  
  var body: some View {
    List {
      /// Be aware it's only available on Xcode 13(beta at his time of June 30th) and later
      /// For older versions of Xcode, should consider using the "binding(for:)" helper after iterating over scrums array itself not the binding array
      ForEach($scrums) { $scrum in
        NavigationLink(destination: ScrumDetailView(scrum: $scrum)) {
          CardView(scrum: scrum)
        }
        .listRowBackground(scrum.color)
      }
    }
    .configureNavigationBar()
    .sheet(isPresented: $isPresented) {
      
    }
  }
  
  private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
    guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
      fatalError("Can't find scrum in array")
    }
    return $scrums[scrumIndex]
  }
}

private extension List {
  func configureNavigationBar() -> some View {
    self.navigationTitle("Daily Scrums")
      .navigationBarItems(trailing: Button(action: { }) {
        Image(systemName: "plus")
      })
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
