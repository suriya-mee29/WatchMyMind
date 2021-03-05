//
//  ActivityCardGroupView.swift
//  WatchMyMind
//
//  Created by Suriya on 2/2/2564 BE.
//

import SwiftUI


enum activityType {
    case AUTO
    case MANUAL
}

struct ActivityCardGroupView: View {
    /// MARK: - PROPERTIES// MARK: - <#BODY#>
 
    let type : activityType
    let activitys : [Activity]
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    var body: some View {
        
            VStack (alignment: .leading){
                //TITLE OF ACTIVITY
                Text((type != activityType.MANUAL) ?  "\(L10n.Header.autoactivity) ( \(activitys.count) )".uppercased():
                        "\(L10n.Header.manualctivity) ( \(activitys.count) )".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
     
                    LazyHGrid(rows: [GridItem(.fixed(215))], alignment: .center, spacing: 0, pinnedViews: [], content: {
                        ForEach(activitys ) { item in
                            //CADR
                            NavigationLink(
                                destination:
                                    
                                    DescriptionView(imageIcon: item.imageIcon, title: item.title, description: item.description, navigationTag: .TO_BIODATA_VIEW)
                                    .environment(\.managedObjectContext, viewContext)
                                ,
                                label: {
                                    ActivityCardView(
                                        activity: item ,
                                        progressColor: (type != activityType.MANUAL) ? Color("pk2") : Color("yn1"),
                                        backgroundColor: (type != activityType.MANUAL) ? Color("gr2") : Color("pk2"))
                                        
                                })
                            
                            
                        
                            
                              
                          //ActivityCardView()
                              .padding(.horizontal,13)
                           
                             
                        }
                        
                    })//LAZY H GRID
                    
                    
                    
                })//: SCROLLVIEW
            }
        } //: VSTACK
    
    }

// MARK: -<#PREVIEW#>
struct ActivityCardGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardGroupView(type: .AUTO, activitys: ac )
            .previewLayout(.sizeThatFits)
            
    }
}
