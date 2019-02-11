//
//  ListViewController.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 09..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cityValues = ["Budapest","Keszthely","Esztergom","Szolnok","Győr"]
    let countyValues = ["Pest megye","Zala megye","Komárom-Esztergom megye","Jász-Nagykun-Szolnok megye","Győr-Moson-Sopron megye"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureView()
    }

    private func configureView() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.31, green:0.71, blue:0.98, alpha:1.0)
        navigationController?.navigationBar.addDropShadow(offSet: CGSize(width: 0, height: 1), radius: 10)
        navigationController?.navigationBar.topItem?.title = "Weather"
        view.backgroundColor = UIColor.white
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath) as! ListTableViewCell

        cell.colorView.layer.cornerRadius = 10.0
        cell.cityLabel.text = cityValues[indexPath.row]
        cell.countyLabel.text = countyValues[indexPath.row]

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "navigateToDetailView") {

            guard let cell = sender as? ListTableViewCell else { return }
            guard let index = tableView.indexPath(for: cell) else { return }
            guard let destinationVC = segue.destination as? DetailsViewController else { return }

            switch index.row {
            case 0: destinationVC.location = .budapest
            case 1: destinationVC.location = .keszthely
            case 2: destinationVC.location = .esztergom
            case 3: destinationVC.location = .szolnok
            case 4: alertMessage()
            default: break
            }
        }
    }

    private func alertMessage() {
        let alertController = UIAlertController(title: title, message: "No weather information.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        let backView = alertController.view.subviews.first?.subviews.first?.subviews.first!
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.white
        alertController.view.tintColor = UIColor(red:0.31, green:0.71, blue:0.98, alpha:1.0)
        present(alertController, animated: true, completion: nil)
    }
}


