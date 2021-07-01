//
//  History.swift
//  Scrumdinger
//

import Foundation

struct History: Identifiable {

  let id: UUID
  let date: Date
  let attendees: [String]
  let lengthInMinutes: Int
  
  internal init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int) {
    self.id = id
    self.date = date
    self.attendees = attendees
    self.lengthInMinutes = lengthInMinutes
  }
}
