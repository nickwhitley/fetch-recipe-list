//
//  fetchRecipeListTests.swift
//  fetchRecipeListTests
//
//  Created by nwhitley.vendor on 1/27/25.
//

//import XCTest
//@testable import fetchRecipeList
//
//final class fetchRecipeListTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import Testing
@testable import fetchRecipeList

struct FetchTests {
    let recipeService: RecipeService
    
    init() {
        recipeService = RecipeService()
    }
    
    @Test func fetchRecipesSuccess() async {
        do {
            let recipes = try await recipeService.fetchRecipes(recipeUrl: .validRecipes)
            #expect(recipes.count > 0)
        } catch {
            print(error)
        }
    }
    
    @Test func fetchRecipesFailMalformedResponse() async {
        async #expect(throws: RecipeServiceError.responseMalformed) {
            try await recipeService.fetchRecipes(recipeUrl: .malformedRecipes)
        }
    }
    
    @Test func fetchRecipesFailEmptyResponse() async {
        async #expect(throws: RecipeServiceError.responseEmpty) {
            try await recipeService.fetchRecipes(recipeUrl: .emptyRecipes)
        }
    }
}
