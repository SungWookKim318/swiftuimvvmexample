//
//  swiftuimvvmexampleApp.swift
//  swiftuimvvmexample
//
//  Created by SungWook Kim on 2023/02/02.
//

import SwiftUI

@main
struct swiftuimvvmexampleApp: App {
    init() {
        self.appFlowCoordinator = AppFlowCoordinator(appDIContainer: self.appDIContainer)
    }
    
    let appDIContainer = AppDIContainer()
    private var appFlowCoordinator: AppFlowCoordinator? = nil
    
    var body: some Scene {
        WindowGroup {
//            MoviesListMainView(queryText: <#T##Binding<String>#>, moviesListViewModel: <#T##MoviesListViewModel#>)
            appFlowCoordinator?.rootView()
        }
    }
}
