//
//  FirstViewController.swift
//  ios-stations
//

import UIKit

class FirstViewController: UIViewController {
    
    var books: [Book]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        
        fetchBooks()
    }
    
    func fetchBooks() {
        BookAPIClient.shared.fetchBooks(offset: 0) { [weak self] (fetchedBooks) in
            guard let self = self else { return }
            
            if let fetchedBooks = fetchedBooks {
                self.books = fetchedBooks
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Failed to fetch books")
            }
        }
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        
        if let book = books?[indexPath.row] {
//            cell.textLabel?.text = book.title
//            cell.detailTextLabel?.text = book.author
        }
        
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

