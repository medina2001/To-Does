//
//  Model.swift
//  TooDoes
//
//  Created by Gabriel de Oliveira Maciel on 03/06/21.
//

import Foundation
import SwiftUI
import Combine

struct Task: Identifiable {
    var id = String()
    var listItem = String()
}

class TaskModel: ObservableObject {
    @Published var tasks = [Task]()
}
