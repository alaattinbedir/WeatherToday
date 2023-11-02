//
//  DailyTableViewCell.swift
//  WeatherTodayApp
//
//  Created by mac on 2.09.2019.
//  Copyright © 2019 Alaattin Bedir. All rights reserved.
//

import UIKit


class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(dailyData: Daily) {
        self.dayLabel.text = Utilities.sharedInstance.getDayFromDate(date: Double(dailyData.dt ?? 0))
        self.highTempLabel.text = Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit: dailyData.temp?.max ?? 0)
        self.lowTempLabel.text = Utilities.sharedInstance.convertFahrenheitToCelsius(fahrenheit: dailyData.temp?.min ?? 0)
    }
}
