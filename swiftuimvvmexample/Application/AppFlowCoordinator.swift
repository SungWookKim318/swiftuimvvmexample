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
//    private let initialView: IntroContentView
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func rootView() -> some View {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMovieSearchFlowCoordinator()
        return flow.makeStartView()
    }
}
