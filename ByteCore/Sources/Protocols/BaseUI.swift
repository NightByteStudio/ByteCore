//
//  BaseUI.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * BaseUI is a protocol that should be use by all base UI components implementation
 * This is to make sure all the view setting up method is called setupViews, and if we need to change the name, we can change it once here
 */
public protocol BaseUI {
    func setupViews()
}
