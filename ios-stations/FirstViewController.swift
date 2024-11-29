//
//  FirstViewController.swift
//  ios-stations
//

import UIKit

class FirstViewController: UIViewController {
    
    var books: [Book]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var clickButton: UIButton!
    
    @IBAction func presentSecondViewController(_ sender: UIButton) {
        let secondViewController = SecondViewController(url: "")

        // presentメソッドでSecondViewControllerを表示
        present(secondViewController, animated: true, completion: nil)
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

