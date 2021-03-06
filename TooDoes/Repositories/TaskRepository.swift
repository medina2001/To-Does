//
//  TaskRepository.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 04/06/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject{
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData(){
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener{ (querySnapshot, error) in
                if let querySnapshot = querySnapshot{
                    self.tasks = querySnapshot.documents.compactMap { document in
                        do{
                            let x = try document.data(as: Task.self)
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func  addTask(_ task: Task){
        var addedTask = task
        addedTask.userId = Auth.auth().currentUser?.uid
        do{
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task){
        if let taskId = task.id{
            do {
                try db.collection("tasks").document(taskId).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    func removeTask(_ task: Task) {
      if let taskID = task.id {
        db.collection("tasks").document(taskID).delete { (error) in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
    
}
