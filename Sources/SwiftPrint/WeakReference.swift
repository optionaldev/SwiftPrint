//
// The  project.
// Created by optionaldev on 28/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

internal class WeakReference {
    
    init(object: AnyObject?) {
        self.object = object
    }
    
    var string: String? {
        if object != nil {
            return Unmanaged<AnyObject>.passUnretained(object!).toOpaque().debugDescription
        }
        return nil
    }
    
    // MARK: - Private
    
    private weak var object: AnyObject?
}
