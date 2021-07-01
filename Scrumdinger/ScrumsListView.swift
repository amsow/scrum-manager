//
//  ScrumListView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct ScrumsListView: View {
  @Binding var scrums: [DailyScrum]
  @State private var newScrumData = DailyScrum.Data()
  @State var isPresented: Bool = false
  
 // @available(iOS 15.0, *)
 // @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    List {
      /// Be aware it's only available on Xcode 13(beta at this time of June 30th) version and later
      /// For older versions of Xcode, should consider using the "binding(for:)" helper after iterating over scrums array itself not the binding array
      ForEach($scrums) { $scrum in
        NavigationLink(destination: ScrumDetailView(scrum: $scrum)) {
          CardView(scrum: scrum)
        }
        .listRowBackground(scrum.color)
      }
    }
    .navigationTitle("Daily Scrums")
      .navigationBarItems(trailing: Button(action: { isPresented = true }) {
        Image(systemName: "plus") })
    
    .sheet(isPresented: $isPresented) {
      NavigationView {
        EditView(scrumData: $newScrumData)
          .navigationBarItems(leading: Button("Dismiss") { isPresented = false },
                              trailing: Button("Add") {
            let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
            scrums.append(newScrum)
            isPresented = false
          })
      }
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
      .navigationBarItems(trailing: Button(action: {}) {
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
