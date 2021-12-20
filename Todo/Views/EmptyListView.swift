//
//  EmptyListView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI


struct EmptyListView: View {
  
  @State private var isAnimated: Bool = false
  
  @ObservedObject var theme = ThemeManager.shared
  let themes = AppData.themeData
  
  let randomImageIdx: Int = Int.random(in: 1...3)
  let tips: [String] = [
    "Use your time wisely.",
    "Slow and steady wins the race.",
    "Keep it short and sweet.",
    "Put hard tasks first.",
    "Reward yourself after work.",
    "Collect tasks ahead of time.",
    "Each night schedule for tomorrow."
  ]
  
  var body: some View {
    
    ZStack {
      VStack(alignment: .center, spacing: 20) {
        
        Image("illustration-no\(randomImageIdx)")
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
          .layoutPriority(1)
          .foregroundColor(themes[theme.themeValue].themeColor)
        
        Text(tips.randomElement() ?? tips[0])
          .layoutPriority(0.5)
          .font(.system(.headline, design: .rounded))
          .foregroundColor(themes[theme.themeValue].themeColor)
      }
      .padding(.horizontal)
      .opacity(isAnimated ? 1 : 0)
      .offset(x: 0, y: isAnimated ? 0 : -50)
      .animation(.easeOut(duration: 1.5), value: isAnimated)
      .onAppear {
        isAnimated.toggle()
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(Color("ColorBase"))
    .edgesIgnoringSafeArea(.all)
  }
}



struct EmptyListView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyListView()
  }
}
