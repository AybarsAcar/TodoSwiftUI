//
//  AddTodoView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI

enum Constants {
  static let priorities = ["High", "Normal", "Low"]
}



struct AddTodoView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) private var persistanceContext
  
  // Theme
  let themes: [Theme] = AppData.themeData
  @ObservedObject var theme = ThemeManager.shared
  
  @State private var name: String = ""
  @State private var priority: String = "Normal"

  @State private var isErrorDisplayed: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""

  
  var body: some View {
    
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          
          TextField("Todo", text: $name)
            .padding()
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          
          Picker("Priority", selection: $priority) {
            ForEach(Constants.priorities, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          
          Button(action: {
            if (!name.isEmpty) {
              let todo = TodoItem(context: persistanceContext)
              todo.name = self.name
              todo.priority = self.priority
              
              do {
                try persistanceContext.save()
              } catch {
                print(error)
              }
            } else {
              isErrorDisplayed = true
              errorTitle = "Invalid Name"
              errorMessage = "Make sure to enter something for\nthe new todo item."
              return
            }
            
            presentationMode.wrappedValue.dismiss()
            
          }, label: {
            Text("Save")
              .font(.system(size: 24, weight: .bold, design: .default))
              .padding()
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(themes[theme.themeValue].themeColor)
              .cornerRadius(9)
              .foregroundColor(.white)
          })
          
        }
        .padding(.horizontal)
        .padding(.vertical, 30)
        
        Spacer()
      }
      .navigationBarTitle("New Todo", displayMode: .inline)
      .toolbar {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Image(systemName: "xmark")
        })
      }
      .alert(isPresented: $isErrorDisplayed) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
      
    }
    .accentColor(themes[theme.themeValue].themeColor)
    .navigationViewStyle(.stack)
  }
}



struct AddTodoView_Previews: PreviewProvider {
  static var previews: some View {
    AddTodoView()
  }
}
