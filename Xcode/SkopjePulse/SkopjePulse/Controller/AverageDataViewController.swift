//
//  AverageDataViewController.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class AverageDataViewController: UIViewController, Storyboarded {
    
    public var presenter: AverageDataPresenter!
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var avgDataTableView: UITableView!
    @IBOutlet weak var sensorTitle: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var measurementLabel: UILabel!    

    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentPressed(_ sender: Any) {
        presenter.processAverageData(for: segment.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAvgDataTableView()
        sensorTitle.text = presenter.getSensorTitle()
        presenter.delegate = self
        presenter.processDefaultPm10()
    }
    
    private func configureAvgDataTableView() {
        avgDataTableView.dataSource = self
        avgDataTableView.delegate = self
        let sensorCell = UINib(nibName: "AverageDataCell", bundle: nil)
        avgDataTableView.register(sensorCell, forCellReuseIdentifier: presenter.cellIdentifier)
        avgDataTableView.delaysContentTouches = false
    }
}

extension AverageDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath) as! AverageDataTableViewCell
        guard presenter.averageData != nil else { return cell }
        cell.configure(with: presenter.averageData[indexPath.row])
        return cell
    }
}

extension AverageDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension AverageDataViewController: AverageDataPresenterDelegate {
    func loading() {
        coordinator?.showloader()
    }
    func finishedLoading(averageData: [AverageData]) {
        self.measurementLabel.text = averageData.first?.getMeasurementType
        self.avgDataTableView.reloadData()
        coordinator?.hideLoader()
    }
}
