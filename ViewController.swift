//
//  ViewController.swift
//  Ten
//
//  Created by Alexandra Gorshkova on 18.06.2018.
//  Copyright © 2018 Alexandra Gorshkova. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UISearchBarDelegate, View {
	
	private var a = [Int]()
	private var indexPathSearch : IndexPath = IndexPath()
	//var timer = Timer()
	private var start = 0.0
	var stop = 0.0
	var presenter = Presenter()


	@IBOutlet var nInput: UITextField!
	@IBOutlet var button: UIButton!
	@IBOutlet var collection: UICollectionView!
	@IBOutlet var indicator: UIActivityIndicatorView!
	@IBOutlet var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.setView(view: self)
		nInput.delegate = self
		searchBarSetup()
	}
	
    func showProgress() {
        self.indicator.startAnimating()
    }
    
    func setResult(result: [Int]) {
        a = result
    }
    
    func showContent() {
        self.indicator.stopAnimating()
        self.collection.reloadData()
    }
    
    func showError(message: String) {
        self.indicator.stopAnimating()
        alert(message: message)
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	

	// MARK: - Button pressed
	@IBAction func buttonPressed(_ sender: Any) {
        guard let text = nInput.text, let inputNumber = Int(text) else {
            return
        }
        presenter.onClick(input: inputNumber)
	}
	
// замер времени
	/*
	@objc func rinTimer() {
		let elapsed = -(self.timer.userInfo as! Date).timeIntervalSinceNow
		print(elapsed)
	} */
	
	// MARK: - Primes calculation
	
		/*    while true {
		i += 1
		var simpleFlag = 0
		
		for p in (2...k)   {
		// тут
		if (i % p) == 0 {
		simpleFlag += 1
		}
		}
		if (simpleFlag == 1) || (simpleFlag == 0) {
		primeNumbers.append(i)
		}
		
		if i == k {
		break
		}
		}
		return primeNumbers */
		
	
	//MARK: - UICollectionViewDelegate
	
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return a.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollCell", for: indexPath) as! MyCell
		if cell.backgroundColor == UIColor.yellow {
			cell.backgroundColor = UIColor.clear
		}
		if indexPathSearch == indexPath {
			cell.backgroundColor = UIColor.yellow
		}
        cell.textCell.text = String(a[indexPath.row])
		return cell
    }
	
	// MARK: - Alert
	
	func alert(message: String) {
		let alertController = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
		alertController.addAction(action)
		present(alertController,animated: true, completion: nil)
	}
	
	// проверка что вводятся только цифры
	// MARK: - check entry for numbers
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
	
	// MARK: - Search number
	
	private func searchNumber(number : Int) -> (mid : Int, mid2: Int?) {
		var min = 0
		var max = a.count - 1
		var mid = 0
		var mid2 : Int? = nil
		if number <= a[max] {
			while min <= max {
				mid = min + (max - min)/2
				if a[mid] == number{
					mid2 = nil
					return (mid,mid2)
				}
				if number < a[mid]{
					max = mid - 1
					mid2 = max
				} else {
					min = mid + 1
					mid2 = min
				}
			}
		}
		return (mid,mid2)
	}
	
	func searchBarSetup() {
		let searchBar = UISearchBar()
		searchBar.showsScopeBar = true
		searchBar.selectedScopeButtonIndex = 0
		searchBar.delegate = self
		
	}
	internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty{
			self.collection.reloadData()
			indexPathSearch = IndexPath()
		} else{
			guard let number = Int(searchText) else {return }
			if !a.isEmpty &&  number <= a.last! {
				let index = searchNumber(number : number)
				indexPathSearch = IndexPath(item: index.mid, section: 0)
				collection.scrollToItem(at: indexPathSearch, at: .top, animated: true)
				collection.reloadItems(at: [indexPathSearch])
				if let mid = index.mid2 {
					indexPathSearch = IndexPath(item: mid, section: 0)
					collection.reloadItems(at: [indexPathSearch])
				}
			} else {
				alert(message: "Проверьте было ли введено число в первую ячейку! Число не должно быть больше первого!"  )
			}
		}
		collection.reloadData()
	}
}
    
    




