//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Amadou Diarra SOW on 23/06/2021.
//

import SwiftUI

struct MeetingHeaderView: View {
  let secondsElapsed: Int
  let secondsRemaining: Int
  
  var progress: Double {
    guard secondsRemaining > 0 else { return 1 }
    let totalSeconds = Double(secondsElapsed + secondsRemaining)
    return Double(secondsElapsed) / totalSeconds
  }
  
  private var minutesRemaining: Int {
    return secondsRemaining / 60
  }
  
  private var minutesRemainingMetric: String {
    return minutesRemaining == 1 ? "minute" : "minutes"
  }
  
  let scrumColor: Color
  
  var body: some View {
    VStack {
      ProgressView(value: progress)
        .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
      HStack {
        VStack(alignment: .leading) {
          Text("Secondes Elapsed")
            .font(.caption)
          Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
          
        }
        Spacer()
        VStack(alignment: .trailing) {
          Text("Secondes Remained")
            .font(.caption)
          HStack {
            Text("\(secondsRemaining)")
            Image(systemName: "hourglass.tophalf.fill")
          }
        }
      }
    }
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("Time remaining"))
    .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
    .padding([.top, .horizontal])
  }
}

struct MeetingHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    MeetingHeaderView(secondsElapsed: 600, secondsRemaining: 300, scrumColor: DailyScrum.data[0].color)
      .previewLayout(.sizeThatFits)
    //.environment(\.colorScheme, .dark)
  }
}
