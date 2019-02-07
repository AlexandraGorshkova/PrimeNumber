//
//  File.swift
//  Ten
//
//  Created by Горшкова А.С. on 27.07.2018.
//  Copyright © 2018 Alexandra Gorshkova. All rights reserved.
//

import Foundation

protocol Listener: class {
	func success(_: [Int]) 
}
class Interactor {
	
	var listener = Listener.self
	var array = [Int]()
	
	func setListener(listener: Listener){
		// вычисления массива простых чисел
		listener.success(array)
	
	}
}
