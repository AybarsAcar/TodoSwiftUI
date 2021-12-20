//
//  FloatingActionButton.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI

struct FloatingActionButton: View {
  
  let systemIcon: String
  let color: Color
  let onClick: () -> Void
  
  
  @State private var isAnimating: Bool = false
  
  var body: some View {
    ZStack {
      
      ZStack {
        Circle()
          .fill(color)
          .opacity(isAnimating ? 0.2 : 0)
          .frame(width: 68, height: 68, alignment: .center)
        
        Circle()
          .fill(color)
          .opacity(isAnimating ? 0.15 : 0)
          .frame(width: 88, height: 88, alignment: .center)
      }
      .blur(radius: isAnimating ? 0 : 1)
      .scaleEffect(isAnimating ? 1 : 0)
      // .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating) TODO FIX ANIMATION BUG
      
      
      Button(action: {
        onClick()
      }, label: {
        Image(systemName: "plus.circle.fill")
          .resizable()
          .scaledToFit()
          .background(Circle().fill(Color("ColorBase")))
          .frame(width: 48, height: 48, alignment: .center)
      })
        .onAppear {
          isAnimating.toggle()
        }
    }
  }
}

struct FloatingActionButton_Previews: PreviewProvider {
  static var previews: some View {
    FloatingActionButton(systemIcon: "plus.circle.fill", color: .blue ,onClick: { })
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
