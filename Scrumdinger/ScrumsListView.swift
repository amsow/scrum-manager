//
//  ScrumListView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct ScrumsListView: View {
  let scrums: [DailyScrum]
  
    var body: some View {
      List {
        ForEach(scrums) { scrum in
          CardView(scrum: scrum)
            .listRowBackground(scrum.color)
        }
      }
    }
}

struct ScrumListView_Previews: PreviewProvider {
    static var previews: some View {
      ScrumsListView(scrums: DailyScrum.data)
        .environment(\.colorScheme, .dark)
    }
}
