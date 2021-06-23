//
//  ScrumDetailView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 11/06/2021.
//

import SwiftUI

struct ScrumDetailView: View {
  @Binding var scrum: DailyScrum
  @State private var data: DailyScrum.Data = DailyScrum.Data()
  @State private var isPresented: Bool = false
  
    var body: some View {
      List {
        Section(header: Text("Meeting Info")) {
          NavigationLink(destination: MeetingView()) {
            Label("Start Meeting", systemImage: "timer")
              .font(.headline)
              .foregroundColor(.accentColor)
              .accessibilityLabel(Text("Start meeting"))
          }
         
          
          HStack {
            Label("Length", systemImage: "clock")
              .accessibilityLabel(Text("Meeting length"))
            Spacer()
            Text("\(scrum.lengthInMinutes) mins")
          }
          
          HStack {
            Label("Color", systemImage: "paintpalette")
            Spacer()
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(scrum.color)
          }
          .accessibilityElement(children: .ignore)
        }
        
        Section(header: Text("Attendees")) {
          ForEach(scrum.attendees, id: \.self) { attendee in
            Label(attendee, systemImage: "person")
              .accessibilityLabel(Text("Person"))
              .accessibilityValue(Text(attendee))
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarItems(trailing: Button("Edit", action: {
        isPresented = true
        data = scrum.data
      }))
      .navigationTitle(scrum.title)
      .fullScreenCover(isPresented: $isPresented) {
        NavigationView {
          EditView(scrumData: $data)
            .navigationTitle(Text(scrum.title))
            .navigationBarItems(leading: Button("Cancel") {
              isPresented = false
            }, trailing: Button("Done") {
              isPresented = false
              scrum.update(from: data)
            })
        }
      }
    }
}

struct ScrumDetailView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        ScrumDetailView(scrum: .constant(DailyScrum.data[0]))
      }
      .environment(\.colorScheme, .dark)
    }
}
