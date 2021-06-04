//
//  ContentView.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import SwiftUI
import Combine

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    var tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView{
                VStack(alignment: .leading){
                    List{
                        ForEach(taskListViewModel.taskCellViewModels){ taskCellViewModel in
                            TaskCell(taskCellViewModel: taskCellViewModel)
                        }.onDelete { indexSet in
                            self.taskListViewModel.removeTasks(atOffsets: indexSet)
                          }
                        if presentAddNewItem{
                            TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(title: "", completed: false))){ task in
                                self.taskListViewModel.addTask(task: task)
                                self.presentAddNewItem.toggle()
                            }
                        }
                    }
                }.navigationBarTitle("Tarefas")
            }
            Button(action: { self.presentAddNewItem.toggle() }) {
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20,height: 20)
                    Text("Adicionar Nova Tarefa")
                }
            }.padding()
        }
    }
    
    func delete(at offsets: IndexSet) {
        
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskListView()
        }
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack{
            Image(systemName: taskCellViewModel.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellViewModel.task.completed.toggle()
                }
            TextField("Adicione o título da tarefa", text: $taskCellViewModel.task.title, onCommit: {
                self.onCommit(self.taskCellViewModel.task)
            })
        }
    }
}
