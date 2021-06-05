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
    var userId: String?
}

