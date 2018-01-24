//
//  UpcomingRouterTests.swift
//  ArcMoviesTests
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import XCTest
import Foundation
@testable import ArcMovies

class UpcomingRouterTests: XCTestCase {
    var view : UpcomingMoviesViewController?
    
    override func setUp() {
        guard let nav = UpcomingMoviesRouter.assembleModule() as? UINavigationController else {
            XCTFail()
            return
        }
        guard let view = nav.childViewControllers.first as? UpcomingMoviesViewController else {
            XCTFail()
            return
        }
        self.view = view
    }
    
    func testModuleAssembly() {
        guard let view = view, let presenter = view.presenter as? UpcomingMoviesPresenter else {
            XCTFail()
            return
        }
        guard let interactor = presenter.interactor as? UpcomingMoviesInteractor else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(view.presenter)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.router)
        XCTAssertNotNil(interactor.output)
    }
}
