//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct DailyScrum: Identifiable {
  let id: UUID
  var title: String
  var attendees: [String]
  var lengthInMinutes: Int
  var color: Color

  
  init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, color: Color) {
    self.id = id
    self.title = title
    self.attendees = attendees
    self.lengthInMinutes = lengthInMinutes
    self.color = color
  }
}

extension DailyScrum {
  static var data: [DailyScrum] {
    [
      DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonhattan"], lengthInMinutes: 10, color: Color("Design")),
      DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, color: Color("App Dev")),
      DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jen", "Sarah"], lengthInMinutes: 1, color: Color("Web Dev"))
    ]
  }
}

extension DailyScrum {
  struct Data {
    var title: String = ""
    var attendees: [String] = []
    var lengthInMinutes: Double = 5.0
    var color: Color = .random
  }
  
  var data: Data {
    return Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), color: color)
  }
}
