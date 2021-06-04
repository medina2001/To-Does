//
//  TaskRepository.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 04/06/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject{
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData(){
        db.collection("tasks").addSnapshotListener{ (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.tasks = querySnapshot.documents.compactMap{ document in
                    try? document.data(as: Task.self)
                }
            }
        }
    }
    
}
