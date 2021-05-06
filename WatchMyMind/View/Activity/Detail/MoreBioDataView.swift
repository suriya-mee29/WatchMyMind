//
//  MoreBioDataView.swift
//  WatchMyMind
//
//  Created by Suriya on 12/2/2564 BE.
//

import SwiftUI
import SwiftUICharts
import HealthKit

struct MoreBioDataView: View {
   
    // MARK: - PROPERTIES
    let sample : HKWorkout?
    let hrv : Double
    var value : [Double] = [122.0,122.0,119,119,118,121,124,123,116,115,124,124,126,125,120,121,120,122,120,120,122,122,117,120,120,119,118,120,120,121]
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "")
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                HeaderDetailIView(date: sample!.startDate, startTime: sample!.startDate, endTime: sample!.endDate)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .trailing){
                        
                        
                        if let bruned = sample?.totalEnergyBurned?.doubleValue(for: .kilocalorie()){
                        let formattedCalories = String(format: "%.2f kcal",bruned)
                            BioDataCardTitleView(title: "ACTIVE KILOCALORIES", imageIcon: "flame", color: Color("wmm"), value: "\(formattedCalories)")
                                .padding(.top)
                        }
                       
                        if let distance = sample?.totalDistance?.doubleValue(for: .meter()){
                            let distanceKm = distance / 1000
                            let formattedMater = String(format: "%.2f km ",distanceKm)
                            BioDataCardTitleView(title: "Total distance", imageIcon: "location.north.line", color: Color("wmm"), value: "\(formattedMater) ")
                        }
                       
                        if let floors = sample?.totalFlightsClimbed?.doubleValue(for: HKUnit.count()){
                            BioDataCardTitleView(title: "Flight Climbed", imageIcon: "arrow.up.right.circle", color: .accentColor, value: "\(floors) floors")
                        }
                        
                        if let strokeCount = sample?.totalSwimmingStrokeCount?.doubleValue(for: HKUnit.count()){
                            BioDataCardTitleView(title: "Stroke Count", imageIcon: "arrow.uturn.left.circle", color: .accentColor, value: "\(strokeCount)")
        
                        }
        
                        BioDataCardTitleView(title: "Avg Hart Rate", imageIcon: "heart", color: Color("wmm"), value: "\(Int(hrv)) BPM")
                            .padding(.top)
                       
                        HStack {
                           Spacer()
                            LineChartView(data: value, title: "Hart Rate",legend: "BMP/Minute" ,style: ChartStyle(backgroundColor: .white, accentColor: Color.blue, gradientColor: GradientColor(start: Color("step"), end: Color.purple), textColor: .accentColor, legendTextColor: Color.gray, dropShadowColor: Color.gray.opacity(0.5)),form: CGSize(width: UIScreen.main.bounds.width * 0.85, height: 100),rateValue: 0)
                            Spacer()
                        }.padding(.bottom)
                        
                        
                        

                       
                    }
                    .padding(.top)
                    .padding(.horizontal)
                })
                
                
                Spacer()
                
            }
        }
        .ignoresSafeArea(.all,edges: .all)
    }
}
// MARK: -PREVIEW
struct MoreBioDataView_Previews: PreviewProvider {
    static var previews: some View {
        Text("dd")
        //MoreBioDataView()
          //  .preferredColorScheme(.light)
    }
}
