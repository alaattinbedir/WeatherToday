//
//  OperationMenuResponse.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 15.06.2022.
//

import Foundation
import ObjectMapper
import ReactiveKit

class OperationMenuResponse: Mappable {
    var operationMenu: [MenuModel] = []

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    func mapping(map: Map) {
        operationMenu <- map["menu"]
    }
}

class MenuModel: Mappable {
    var menuId: MenuCode = .unknown
    var parentId: Int = 0
    var name: String = ""
    var keyword: String = ""
    var showOnMenuTree: Bool = false
    var isNew: Bool = false
    var subMenus: [MenuModel] = []
    var menuApiId: Int = 0
    var menuIcon: String = ""
    var order: Int = 0
    var tag: String?
    var handleSuccess: (() -> Void)?

    init() {
        // Intentionally unimplemented
    }

    required init?(map _: Map) {
        // Intentionally unimplemented
    }

    init(menuId: MenuCode,
         parentId: Int = 0,
         name: String = "",
         keyword: String = "",
         menuApiId _: Int = 0,
         menuIcon: String = "",
         showOnMenuTree: Bool = false,
         isNew: Bool = false,
         subMenus: [MenuModel] = [],
         order: Int = 0,
         tag: String? = nil,
         handleSuccess: (() -> Void)? = nil) {
        self.menuId = menuId
        self.parentId = parentId
        self.name = name
        self.keyword = keyword
        self.menuIcon = menuIcon
        self.showOnMenuTree = showOnMenuTree
        self.isNew = isNew
        self.subMenus = subMenus
        self.order = order
        self.tag = tag
        self.handleSuccess = handleSuccess
    }

    func mapping(map: Map) {
        menuId <- map["menuApiId"]
        parentId <- map["parentId"]
        name <- map["name"]
        keyword <- map["keyword"]
        menuApiId <- map["menuApiId"]
        menuIcon <- map["menuIcon"]
        showOnMenuTree <- map["showOnMenuTree"]
        isNew <- map["isNew"]
        subMenus <- map["subMenu"]
        order <- map["order"]
    }    
}
