//
//  AppFlowCoordinator.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation
import SwiftUI

final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func startView() -> some View {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMovieSearchFlowCoordinator()
        return flow.makeStartView()
    }
}
