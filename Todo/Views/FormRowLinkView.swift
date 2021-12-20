//
//  FormRowLinkView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI


struct FormRowLinkView: View {
  
  let icon: String
  let color: Color
  let text: String
  let link: String
  
  var body: some View {
    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(color)
        Image(systemName: icon)
          .imageScale(.large)
          .foregroundColor(.white)
      }
      .frame(width: 36, height: 36, alignment: .center)
      
      Text(text)
        .foregroundColor(.gray)
      
      Spacer()
      
      Button(action: {
        
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
          return
        }
        
        UIApplication.shared.open(url as URL)
        
      }, label: {
        Image(systemName: "chevron.right")
          .font(.system(size: 14, weight: .semibold, design: .rounded))
      })
        .tint(Color(.systemGray2))
    }
  }
}



struct FormRowLinkView_Previews: PreviewProvider {
  static var previews: some View {
    FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://www.aybarsacar.dev")
      .previewLayout(.fixed(width: 375, height: 60))
      .padding()
  }
}
