//
//  TaskCellViewModel.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable{
    @Published var taskRepository = TaskRepository()
    @Published var task: Task
    
    var id: String = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map{ task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap{ task in
                task.id 
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{ [weak self] task in
                self?.taskRepository.updateTask(task )
            }
            .store(in: &cancellables)
    }
}
