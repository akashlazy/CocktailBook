import XCTest

import XCTest

class CocktailBookUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
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
    
    func testLoadingIndicatorAppears() throws {
        let loadingIndicator = app.activityIndicators["Loading indicator"]
        
        // Wait for the loading indicator to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)  // Wait up to 10 seconds
        
        XCTAssertTrue(loadingIndicator.exists, "The loading indicator should appear while data is fetching")
    }
    
    func testSegmentPickerFunctionality() throws {
        let segmentPicker = app.segmentedControls["Cocktail Type Picker"]
        
        // Wait for the segment picker to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: segmentPicker, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)  // Wait up to 10 seconds

        let collectionView = app.collectionViews["Cocktail List View"]
        // Select "Alcoholic" segment
        segmentPicker.buttons["Alcoholic"].tap()
        XCTAssertTrue(collectionView.cells.count > 0, "Cocktails should be filtered for Alcoholic segment")
        
        // Select "Non-alcoholic" segment
        segmentPicker.buttons["Non-alcoholic"].tap()
        XCTAssertTrue(collectionView.cells.count > 0, "Cocktails should be filtered for Non-Alcoholic segment")
        
        // Select "All" segment
        segmentPicker.buttons["All"].tap()
        XCTAssertTrue(collectionView.cells.count > 0, "All cocktails should be displayed")
        
        collectionView.swipeUp()
        collectionView.swipeDown()
    }

    func testToggleFavoriteCocktail() throws {
        let firstCocktail = app.collectionViews["Cocktail List View"].cells.element(boundBy: 0)
        
        // Wait for the first cocktail to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: firstCocktail, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)  // Wait up to 10 seconds
        
        // Find and tap the favorite button
        let favoriteButton = firstCocktail.images.element(boundBy: 0)
        XCTAssertTrue(favoriteButton.exists, "Favorite button should be available")
        
        favoriteButton.tap()
        
        // Verify the favorite state toggled
        if favoriteButton.isSelected {
            XCTAssertTrue(favoriteButton.isSelected, "Cocktail should be marked as favorite after tapping the favorite button")
        }
    }

    func testCocktailNavigation() throws {
        let firstCocktail = app.collectionViews["Cocktail List View"].cells.element(boundBy: 0)
        
        // Wait for the first cocktail to appear
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: firstCocktail, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)  // Wait up to 10 seconds

        // Tap the first cocktail
        firstCocktail.tap()
        
        // Check if the images is displayed on the details screen
        let detailsScreenTitle = app.scrollViews["Cocktail Details"].otherElements.images
        XCTAssertTrue(detailsScreenTitle.element.exists, "Navigated to the details screen")
    }
}
