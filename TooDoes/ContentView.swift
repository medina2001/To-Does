//
//  ContentView.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskModel = TaskModel()
    @State var newToDo : String = ""
    
    var searchBar : some View{
        HStack{
            TextField("Enter in a new task", text: self.$newToDo)
            Button(action: self.addNewToDo, label: {
                Text("Add New")
            })
        }
    }
    
    func addNewToDo(){
        taskModel.tasks.append(Task(id: String(taskModel.tasks.count + 1),
                                    listItem: newToDo))
        self.newToDo = ""
    }
    
    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                List{
                    ForEach(self.taskModel.tasks){ task in
                        Text(task.listItem)
                    }.onMove(perform: { indices, newOffset in
                        taskModel.tasks.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .onDelete { (indexSet) in
                        self.taskModel.tasks.remove(atOffsets: indexSet)
                    }
                }.navigationBarTitle("Lista Tarefas")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                
        }
    }
}
