//
//  ActivityCardGroupView.swift
//  WatchMyMind
//
//  Created by Suriya on 2/2/2564 BE.
//

import SwiftUI


enum activityType : String{
    case AUTO = "AUTO"
    case MANUAL = "MANUAL"
}

struct ActivityCardGroupView: View {
    /// MARK: - PROPERTIES// MARK: - BODY
 
    let type : activityType
    var autoActivitys : [AutoActivitiesModel] = []
    var manualActivity : [ManualActivitiesModel] = []
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    @Environment(\.managedObjectContext) private var viewContext
    @State  var isActive : Bool = false
    
    // MARK: - BODY
    var body: some View {
        
            VStack (alignment: .leading){
                //TITLE OF ACTIVITY
                Text((type != activityType.MANUAL) ?  "\(L10n.Header.autoactivity) ( \(autoActivitys.count) )".uppercased():
                        "\(L10n.Header.manualctivity) ( \(manualActivity.count) )".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
     
                    LazyHGrid(rows: [GridItem(.fixed(215))], alignment: .center, spacing: 0, pinnedViews: [], content: {
                        
                        if type == activityType.AUTO{
                        ForEach( autoActivitys) { activity in
                           
                            //CADR
                            NavigationLink(
                                destination: DescriptionView(activity: activity , type: type, navigationTag: .TO_BIODATA_VIEW)
                                    .environment(\.managedObjectContext, viewContext),
                                label: {
                                    ActivityCardView(
                                    activity: activity ,
                                    type: type.rawValue, progressColor: (type != activityType.MANUAL) ? Color("wmm") : Color("blue1"),backgroundColor: (type != activityType.MANUAL) ? Color.white : Color.white )
                                    
                                })
                         
                              .padding(.horizontal,13)
                           
                             
                        }
                        }else{
                        ForEach( manualActivity) { activity in
                            //CADR
                            NavigationLink(
                                destination:
                                    DescriptionView(manualActivity: activity , type: type, navigationTag: .OTHER)
                                    .environment(\.managedObjectContext, viewContext),
                                
                                label: {
                                    ActivityCardView(
                                        manualActivity: activity ,
                                        type: type.rawValue, progressColor: (type != activityType.MANUAL) ? Color("wmm") : Color("blue1"),
                                        backgroundColor: (type != activityType.MANUAL) ? Color.white : Color.white )
                                        
                                })
                            
                            
                        
                                
                            //ActivityCardView()
                                .padding(.horizontal,13)
                            
                                
                        }
                        }
                        
                    })//LAZY H GRID
                    
                    
                    
                })//: SCROLLVIEW
            }
        } //: VSTACK
    
    }

// MARK: -<#PREVIEW#>
struct ActivityCardGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardGroupView(type: .AUTO, autoActivitys: [],manualActivity: [])
            .previewLayout(.sizeThatFits)
            
    }
}
