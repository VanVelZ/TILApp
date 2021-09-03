//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Zach Vandervelden on 9/2/21.
//

import Vapor
import Leaf

struct WebsiteController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexHandler)
    }
    func indexHandler(_ req: Request)
    ->EventLoopFuture<View>{
        return req.view.render("index")
    }
}


