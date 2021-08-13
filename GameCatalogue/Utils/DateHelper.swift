//
//  DateHelper.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 12/08/21.
//

import Foundation

struct DateHelper {
    static func format(date: String) -> String {
      let arr = date.components(separatedBy: "-")
      let month = ["01": "January", "02": "February", "03": "March", "04": "April",
                   "05": "May", "06": "June", "07": "July", "08": "August", "09":
                    "September", "10": "October", "11": "November", "12": "December"]

      return "\(arr[2]) \(month[arr[1]]!) \(arr[0])"
    }
}
