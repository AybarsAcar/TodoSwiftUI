//
//  FormStaticView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI


struct FormRowStaticView: View {
  
  var icon: String
  var firstText: String
  var secondText: String
  
  var body: some View {
    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(.gray)
        Image(systemName: icon)
          .foregroundColor(.white)
      }
      .frame(width: 36, height: 36, alignment: .center)
      
      Text(firstText)
        .foregroundColor(.gray)
      
      Spacer()
      
      Text(secondText)
    }
  }
}



struct FormStaticView_Previews: PreviewProvider {
  static var previews: some View {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
      .previewLayout(.fixed(width: 375, height: 60))
      .padding()
  }
}
