//
//  MockCitiesTableView.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class MockCitiesTableView: UITableView, UITableViewDelegate  {
    var dequeueReusableCellisCalled = false
    var tableViewdidSelectRowAtIsCalled = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellisCalled = true
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewdidSelectRowAtIsCalled = true
    }
}
