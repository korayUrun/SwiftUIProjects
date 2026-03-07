//
//  ViewState.swift
//  WheaterAppDay2
//
//  Created by Koray Urun on 7.03.2026.
//

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failure(String)
}
