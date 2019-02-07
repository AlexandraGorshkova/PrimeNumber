//
//  Presenter.swift
//  Ten
//
//  Created by Горшкова А.С. on 31.07.2018.
//  Copyright © 2018 Alexandra Gorshkova. All rights reserved.
//

import Foundation

protocol View: class {
    
    func showProgress()
    
    func setResult(result: [Int])
    
    func showContent()
    
    func showError(message: String)
}


class Presenter {
    
    var view: View?
	
	func setView(view : View) {
		self.view = view
	}
	func onClick(input: Int) {
        view?.showProgress()
        if input < Int.max && input != 0 {
            //self.timer.invalidate()
            var start = 0.0
            var stop = 0.0
            //self.timer = Timer.scheduledTimer(timeInterval : 1.0,target: self,selector: #selector(rinTimer),userInfo: Date(), repeats: true)
            start = Date().timeIntervalSince1970
            DispatchQueue.global().async {
                let result = primeNumbers(k: input)
                DispatchQueue.main.async {
                    //self.timer.invalidate()
                    stop = Date().timeIntervalSince1970
                    self.view?.setResult(result: result)
                    self.view?.showContent()
                }
            }
        } else {
            self.view?.showError(message: "Введите другое число")
        }
	}
}


private func primeNumbers(k : Int) -> [Int] {
    var primeNumbers = [Int]()
    let i = 2
    primeNumbers.append(i)
    primeNumbers.append(i+1)
    for j in 2...k{
        let m = Int(sqrt(Double(j)))
        if m > 1 && !(2...m).contains(where: {j % $0 == 0 }) {
            primeNumbers.append(j)
        }
    }
    return primeNumbers
}

