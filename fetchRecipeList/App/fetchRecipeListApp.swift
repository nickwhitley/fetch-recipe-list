//
//  fetchRecipeListApp.swift
//  fetchRecipeList
//
//  Created by nwhitley.vendor on 1/27/25.
//

import SwiftUI
import SwiftData

@main
struct fetchRecipeListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let recipeListViewModel = RecipeListViewModel(recipeService: RecipeService())

    var body: some Scene {
        WindowGroup {
            RecipeListScreen()
        }
        .modelContainer(sharedModelContainer)
        .environment(recipeListViewModel)
    }
}
