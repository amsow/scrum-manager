//
//  ScrumTimer.swift
//  Scrumdinger
//

import Foundation

final class ScrumTimer: ObservableObject {
  struct Speaker: Identifiable {
    let id = UUID()
    let name: String
    var isCompleted: Bool
  }
  @Published var activeSpeaker = ""
  @Published var secondsElapsed = 0
  @Published var secondsRemaining = 0
  private(set) var speakers: [Speaker]
  private(set) var lengthInMinutes: Int
  var speakerChangedAction: (() -> Void)?
  
  private var timer: Timer?
  private var timerStopped = false
  private var frequency: TimeInterval { 1.0 / 60.0 }
  private var lengthInSecondes: Int { lengthInMinutes * 60 }
  private var secondsPerSpeaker: Int { lengthInSecondes / speakers.count }
  private var secondsElapsedForSpeaker: Int = 0
  private var speakerIndex: Int = 0
  private var speackerText: String {
    return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
  }
  private var startDate: Date?
  
  init(lengthInMinutes: Int = 0, attendees: [String] = []) {
    self.lengthInMinutes = lengthInMinutes
    speakers = attendees.isEmpty ? [Speaker(name: "Player 1", isCompleted: false)] : attendees.map { Speaker(name: $0, isCompleted: false) }
    secondsRemaining = lengthInSecondes
    activeSpeaker = speackerText
  }
  
  func startScrum() {
    changeToSpeaker(at: 0)
  }
  
  func stopScrum() {
    timer?.invalidate()
    timer = nil
    timerStopped = true
  }
  
  func skipSpeaker() {
    changeToSpeaker(at: speakerIndex + 1)
  }
  
  func changeToSpeaker(at index: Int) {
    if index > 0 {
      let previousSpeakerIndex = index - 1
      speakers[previousSpeakerIndex].isCompleted = true
    }
    
    secondsElapsedForSpeaker = 0
    
    guard index < speakers.count else { return }
    
    speakerIndex = index
    activeSpeaker = speackerText
    
    secondsElapsed = index * secondsPerSpeaker
    secondsRemaining = lengthInSecondes - secondsElapsed
    startDate = Date()
    
    timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
      if let self = self , let startDate = self.startDate {
        let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
        self.update(secondsElapsed: Int(secondsElapsed))
      }
    }
  }
  
  private func update(secondsElapsed: Int) {
    secondsElapsedForSpeaker = secondsElapsed
    self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
    
    guard secondsElapsed <= secondsPerSpeaker else { return }
    
    secondsRemaining = max(lengthInSecondes - self.secondsElapsed, 0)
    
    guard !timerStopped else { return }
    
    if secondsElapsedForSpeaker >= secondsPerSpeaker {
      changeToSpeaker(at: speakerIndex + 1)
      speakerChangedAction?()
    }
  }
  
  func reset(lengthInMinutes: Int, attendees: [String]) {
    self.lengthInMinutes = lengthInMinutes
    speakers = attendees.isEmpty ? [Speaker(name: "Player 1", isCompleted: false)] : attendees.map { Speaker(name: $0, isCompleted: false) }
    secondsRemaining = lengthInSecondes
    activeSpeaker = speackerText
  }
}

extension DailyScrum {
  var timer: ScrumTimer { ScrumTimer(lengthInMinutes: lengthInMinutes, attendees: attendees) }
}
