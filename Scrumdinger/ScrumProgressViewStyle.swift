//
//  ScrumProgressViewStyle.swift
//  Scrumdinger
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
  
  let scrumColor: Color
  
  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(scrumColor.accessibleFontColor)
        .frame(height: 20)
      
      ProgressView(configuration)
        .frame(height: 12)
        .padding(.horizontal)
    }
  }
}
