//
//  FirstViewController.swift
//  ios-stations
//

import UIKit

class FirstViewController: UIViewController {
    
    var books: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // UIRefreshControl の設定
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshBooks), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshBooks() {
        fetchBooks(offset: 0)
    }
    
    @IBAction func fetchBooks(_ sender: UIButton) {
        fetchBooks(offset: books.count)
    }
    
    private func fetchBooks(offset: Int) {
        BookAPIClient.shared.fetchBooks(offset: offset) { [weak self] (fetchedBooks) in
            guard let self = self else { return }
            
            if let fetchedBooks = fetchedBooks {
                self.books = fetchedBooks
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing() // リフレッシュ終了
                }
            } else {
                print("Failed to fetch books")
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing() // エラー時もリフレッシュ終了
                }
            }
        }
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        cell.titleLabel.text = book.title
        cell.detailLabel.text = book.detail
        cell.element = book
        
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: book.url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationVC = segue.destination as? SecondViewController,
           let url = sender as? String {
            destinationVC.url = url
        }
    }
}
