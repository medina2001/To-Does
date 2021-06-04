//
//  TaskListViewModel.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var  taskRepository = TaskRepository()
    
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks
            .map{ tasks in
                tasks.map{ task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTask(task: Task){
        taskRepository.addTask(task)
    }
    
    func removeTasks(atOffsets indexSet: IndexSet) {
      let viewModels = indexSet.lazy.map { self.taskCellViewModels[$0] }
      viewModels.forEach { taskCellViewModel in
        taskRepository.removeTask(taskCellViewModel.task)
      }
    }
}
