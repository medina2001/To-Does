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
                        }
                        if presentAddNewItem{
                            TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(title: "", completed: false)))
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
    
    var body: some View {
        HStack{
            Image(systemName: taskCellViewModel.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
            Text(taskCellViewModel.task.title)
        }
    }
}
