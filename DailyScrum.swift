//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 10/06/2021.
//

import SwiftUI

struct DailyScrum {
  var title: String
  var attendees: [String]
  var lengthInMinutes: Int
  var color: Color
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
