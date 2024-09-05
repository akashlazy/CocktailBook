import XCTest
import Combine
@testable import CocktailBook

class CocktailBookTests: XCTestCase {
    
    var viewModel: CocktailViewModel!
    var api: CocktailsAPI!
    
    override func setUp() {
        super.setUp()
        api = FakeCocktailsAPI()
        viewModel = CocktailViewModel(api: api)
        
        // Clear UserDefaults before each test
        clearUserDefaults()
    }
    
    private func clearUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    override func tearDown() {
        viewModel = nil
        api = nil
        super.tearDown()
    }
    
    func testFetchAllCocktailsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch all cocktails")
        
        // Act
        viewModel.fetchAllCocktails()
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(self.viewModel.isLoading, "The loading indicator should be hidden after fetching data")
            XCTAssertNil(self.viewModel.errorMessage, "There should be no error message")
            XCTAssertFalse(self.viewModel.filteredCocktails.isEmpty, "Filtered cocktails should not be empty")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchAllCocktailsFailure() {
        // Arrange
        api = FakeCocktailsAPI(withFailure: .count(3))
        viewModel = CocktailViewModel(api: api)
        let expectation = XCTestExpectation(description: "Fetch all cocktails failure")
        
        // Act
        viewModel.fetchAllCocktails()
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(self.viewModel.isLoading, "The loading indicator should be hidden after fetching data")
            XCTAssertNotNil(self.viewModel.errorMessage, "There should be an error message")
            XCTAssertTrue(self.viewModel.filteredCocktails.isEmpty, "Filtered cocktails should be empty in case of failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFilterCocktails() {
        // Arrange
        let expectation = XCTestExpectation(description: "Filter cocktails")
        viewModel.fetchAllCocktails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.viewModel.filterCocktails(by: .alcoholic)
            XCTAssertTrue(self.viewModel.filteredCocktails.allSatisfy { $0.type == .alcoholic }, "Filtered cocktails should only contain alcoholic cocktails")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testToggleFavorite() {
        // Arrange
        let expectation = XCTestExpectation(description: "Toggle favorite")
        viewModel.fetchAllCocktails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let cocktail = self.viewModel.filteredCocktails.first!
            self.viewModel.toggleFavorite(cocktail)
            XCTAssertTrue(self.viewModel.isFavorite(cocktail), "Cocktail should be marked as favorite")
            
            self.viewModel.toggleFavorite(cocktail)
            XCTAssertFalse(self.viewModel.isFavorite(cocktail), "Cocktail should be unmarked as favorite")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
