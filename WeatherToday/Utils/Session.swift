//
//  Session.swift
//  PhotoApp
//
//  Created by Alaattin Bedir on 2.03.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

class Session {
    
    var Authorization: String?
    
    init() {
        
    }
    
    public class var sharedInstance: Session {
        struct Singleton {
            static let instance: Session = Session()
        }
        return Singleton.instance
    }
    
}

