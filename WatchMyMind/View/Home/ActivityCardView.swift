//
//  ActivityCardView.swift
//  WatchMyMind
//
//  Created by Suriya on 1/2/2564 BE.
//

import SwiftUI

struct ActivityCardView: View {
    // MARK: - PROPERTIES
    var activity : AutoActivitiesModel =  AutoActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", progress: 21, everyDay: true, time: 0, round: 0, NoOfDate: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date())
    var manualActivity : ManualActivitiesModel = ManualActivitiesModel(createdby: "", description: "", imageIcon: "", title: "", type: "", everyDay: false, time: 0, round: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date())
    let type : String
    let progressColor : Color
    let backgroundColor : Color
    
    @State private var isAnnimating : Bool = false
    @State private var toDo : Int = 0
    @State private var done : Int = 0
    var activityStroage = ActivityStorage()
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text((type == activityType.AUTO.rawValue ? activity.title.uppercased() :
                    manualActivity.title.uppercased())
            )
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(2)
                .padding(.horizontal)
                .foregroundColor(Color.black)
                .padding(.bottom)
            
            Image((type == activityType.AUTO.rawValue ? activity.imageIcon :
                    manualActivity.imageIcon))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .scaleEffect(isAnnimating ? 1.0 : 0.6)
           
            Text(done != 0 ? "Done \(done) times" : "")
                .foregroundColor(Color("stand"))
                  .font(.footnote)
                  .fontWeight(.bold)
              
//            RingGraphView(value: CGFloat( Int(activity.progrss ) ?? 0 ), color: progressColor)
                
            
          
            
        }
        .frame(width: 155, height: 198, alignment: .center)
        .background(backgroundColor.cornerRadius(30).shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 5))
       .background(
            RoundedRectangle(cornerRadius: 30).stroke(Color.gray,lineWidth: 0.5)
        )
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.5)){
                isAnnimating = true
            }
            self.activityStroage.activityCount(path: type == activityType.AUTO.rawValue ? self.activity.activityPath: manualActivity.activityPath) { success, numberOfCollection in
                if success{
                    self.done = numberOfCollection
                    if type == activityType.AUTO.rawValue {
                        
                        self.toDo = activity.todo
                        
                    }else{
                        self.toDo =  manualActivity.todo
                    }
                    
                }else{
                    
                }
            }

        })
        .onDisappear(perform: {
            isAnnimating = false
        })
        
    }
}
     // MARK: -PREVIEW
struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardView(activity : AutoActivitiesModel(createdby: "de", description: "ssssss", imageIcon: "play2", title: "wwwwww", type: activityType.AUTO.rawValue, progress: 21 , everyDay: true, time: 0, round: 0, NoOfDate: 0, activityPath: "", observedPath: "",startDate: Date(),endDate:Date()), type: "AUTO", progressColor: Color.green, backgroundColor: Color.white)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
