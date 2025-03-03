//
//  NewsViewModelTest.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
import Combine
@testable import news_matters

class NewsViewModelTests: XCTestCase {
    var viewModel: NewsViewModelProtocol!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchNewsSuccess() {
        let expectedNews = [TestFactory.aNews]
        let repository = MockNewsRepository(result: .success(expectedNews))
        viewModel = NewsViewModel(repository: repository)
        let expectation = XCTestExpectation(description: "News fetched and data updated")
        
        var receivedStates: [NewsViewModel.State] = []
        viewModel.updates
            .sink { state in
                receivedStates.append(state)
                switch state {
                case .dataUpdated:
                    expectation.fulfill()
                case .error(let error):
                    XCTFail("Fetch failed \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchNews()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.viewData.count, 1)
    }
    
    func testFetchNewsFailure() {
        let expectedError = APIError.fakeError
        let repository = MockNewsRepository(result: .failure(expectedError))
        viewModel = NewsViewModel(repository: repository)
        let expectation = XCTestExpectation(description: "Error received from fetchNews")
        
        var receivedStates: [NewsViewModel.State] = []
        viewModel.updates
            .sink { state in
                receivedStates.append(state)
                if case .error = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchNews()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.viewData.isEmpty)
    }
}

class MockNewsRepository: NewsRepositoryProtocol {
    let result: Result<[News], Error>
    
    init(result: Result<[News], Error>) {
        self.result = result
    }
    
    func getNews() -> AnyPublisher<[News], Error> {
        return result.publisher
            .eraseToAnyPublisher()
    }
}
