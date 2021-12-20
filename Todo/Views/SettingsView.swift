//
//  SettingsView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI


struct SettingsView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var appIconManager: AppIconManager
  
  let themes: [Theme] = AppData.themeData
  
  @ObservedObject var theme = ThemeManager.shared
  
  
  var body: some View {
    
    NavigationView {
      VStack(alignment: .center, spacing: 0) {
        
        // FORM
        Form {
          // Section 1
          Section(header: Text("Choose the app icon")) {
            Picker(
              selection: $appIconManager.currentIndex,
              label: HStack {
                ZStack {
                  RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .strokeBorder(Color.primary, lineWidth: 2)
                  
                  Image(systemName: "paintbrush")
                    .font(.system(size: 28, weight: .regular, design: .default))
                  .foregroundColor(.primary)
                }
                .frame(width: 32, height: 32, alignment: .center)
                
                Text("App Icons".uppercased())
                  .fontWeight(.bold)
                  .foregroundColor(.primary)
                  .padding(.leading, 8)
              }
            ) {
              ForEach(0..<appIconManager.iconNames.count) { i in
                HStack {
                  Image(uiImage: UIImage(named: self.appIconManager.iconNames[i] ?? "Blue") ?? UIImage())
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44, alignment: .center)
                    .cornerRadius(9)
                  
                  Spacer().frame(width: 8)
                  
                  Text(appIconManager.iconNames[i] ?? "Blue")
                    .frame(alignment: .leading)
                }
                .padding(3)
              }
            }
            // triggered when a selection occurs
            .onReceive([appIconManager.currentIndex].publisher.first()) { value in
              let index = appIconManager.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
              
              if index != value {
                UIApplication.shared.setAlternateIconName(appIconManager.iconNames[value]) { error in
                  if let error = error {
                    print(error.localizedDescription)
                  } else {
                    print("Success!")
                  }
                }
              }
            }
          }
          .padding(.vertical, 3)
          
          // Section 2
          Section(
            header: HStack {
              Text("Choose the app theme")
              Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 12, height: 12, alignment: .center)
                .foregroundColor(themes[theme.themeValue].themeColor)
            }
          ) {
            List {
              
              ForEach(themes) { item in
                
                Button(action: {
                  // set the item that we will store in the local storage UserDefaults
                  theme.themeValue = item.id
                  UserDefaults.standard.set(theme.themeValue, forKey: "Theme")
                }, label: {
                  
                  HStack {
                    Image(systemName: "circle.fill")
                      .foregroundColor(item.themeColor)
                    
                    Text(item.themeName)
                    
                    Spacer()
                    
                    if item.id == themes[theme.themeValue].id {
                      Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .foregroundColor(item.themeColor)
                    }
                  }
                })
                  .accentColor(.primary)
                
              }
            }
          }
          .padding(.vertical, 2)
          
          // Section 3
          Section(header: Text("Follow us on social media")) {
            FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://www.aybarsacar.dev")
            FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://twitter.com/aybarsacar")
            FormRowLinkView(icon: "play.rectangle", color: .red, text: "YouTube", link: "https://youtube.com/aybarsacar")
          }
          
          // Section 4
          Section(header: Text("About application")) {
            FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
            FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
            FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Aybars Acar")
            FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Aybars Acar")
            FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
          }
          .padding(.vertical, 3)
        }
        .listStyle(.grouped)
        .environment(\.horizontalSizeClass, .regular)
        
        // FOOTER
        Text("Copyright © All rights reserved.")
          .multilineTextAlignment(.center)
          .font(.footnote)
          .foregroundColor(.secondary)
          .padding(.top, 6)
          .padding(.bottom, 8)
      }
      .toolbar(content: {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Image(systemName: "xmark")
        })
      })
      .navigationBarTitle("Settings", displayMode: .inline)
      .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
    }
    .accentColor(themes[theme.themeValue].themeColor)
    .navigationViewStyle(.stack)
  }
}



struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .environmentObject(AppIconManager())
  }
}
