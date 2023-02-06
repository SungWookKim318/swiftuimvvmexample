//
//  RepositoryTask.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
