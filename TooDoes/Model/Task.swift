//
//  Model.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
}

#if DEBUG
let testDataTasks = [
    Task(title: "Levar o dog pra passear", completed: true),
    Task(title: "Fazer prova da faculdade", completed: false),
    Task(title: "Comprar pão", completed: false),
    Task(title: "Pagar fatura do cartão", completed: false),
    Task(title: "Fazer exercícios", completed: false)
]
#endif
