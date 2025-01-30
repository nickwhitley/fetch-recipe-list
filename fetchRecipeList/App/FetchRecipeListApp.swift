import SwiftUI
import SwiftData

@main
struct FetchRecipeListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RecipeListScreen()
                .addEnvironments()
        }
        .modelContainer(sharedModelContainer)
        
    }
}

extension View {
    func addEnvironments() -> some View {
        let recipeListViewModel = {
            let isRunningInPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
            return RecipeListViewModel(recipeService: isRunningInPreview
                                       ? MockRecipeService()
                                       : RecipeService(networkService: NetworkService()))
        }()
        
        return self
            .environment(recipeListViewModel)
    }
}
