//
//  ContentView.swift
//  Todo
//
//  Created by Aybars Acar on 20/12/2021.
//

import SwiftUI


struct ContentView: View {
  
  // read the shared context - internal storage
  @Environment(\.managedObjectContext) private var persistanceContext
  
  @FetchRequest(entity: TodoItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.name, ascending: true)])
  var todos: FetchedResults<TodoItem>
  
  // Theme
  let themes: [Theme] = AppData.themeData
  @ObservedObject var theme = ThemeManager.shared
  
  
  @State private var isAddTodoViewDisplayed: Bool = false
  @State private var isSettingsViewDisplayed: Bool = false
  
  
  var body: some View {
    
    NavigationView {
      ZStack {
        List {
          ForEach(todos, id: \.self) { todo in
            HStack {
              Circle()
                .frame(width: 12, height: 12, alignment: .center)
                .foregroundColor(colorPriority(todo.priority ?? "Normal"))
              
              Text(todo.name ?? "Unknown")
                .fontWeight(.semibold)
              
              Spacer()
              
              Text(todo.priority ?? "Unknown")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(3)
                .frame(minWidth: 62)
                .overlay(Capsule().stroke(.secondary , lineWidth: 0.75))
            }
            .padding(.vertical, 10)
          }
          .onDelete { indexSet in
            deleteTodo(at: indexSet)
          }
        }
        .listStyle(.plain)
        .navigationBarTitle("Todo", displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              isSettingsViewDisplayed = true
            }, label: {
              Image(systemName: "paintbrush")
                .imageScale(.large)
            })
              .sheet(isPresented: $isSettingsViewDisplayed, onDismiss: {
                isSettingsViewDisplayed = false
              }, content: {
                SettingsView()
              })
          }
        }
        
        if todos.count <= 0 {
          EmptyListView()
        }
        
      }
      .sheet(isPresented: $isAddTodoViewDisplayed, onDismiss: {isAddTodoViewDisplayed = false}) {
        AddTodoView()
      }
      .overlay(
        FloatingActionButton(systemIcon: "plus.circle.fill", color: themes[theme.themeValue].themeColor) {
          isAddTodoViewDisplayed = true
        }
          .padding(.bottom, 15)
          .padding(.trailing, 15),
        alignment: .bottomTrailing
      )
    }
    .accentColor(themes[theme.themeValue].themeColor)
    .navigationViewStyle(.stack)
  }
  
  
  private func deleteTodo(at offsets: IndexSet) {
    for i in offsets {
      persistanceContext.delete(todos[i])
    }
    
    // save the changes to db
    do {
      try persistanceContext.save()
    } catch {
      print(error)
    }
  }
  
  
  private func colorPriority(_ priority: String) -> Color {
    switch priority {
    case "High":
      return .pink
    case "Normal":
      return .green
    case "Low":
      return .blue
    default:
      return .gray
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
