//
//  ActivityView.swift
//  Improve
//
//  Created by Apoorva Kanekal on 9/28/23.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        NavigationView{
            VStack(content:{
                Text("Activities")
            })
            .padding()
            .navigationBarTitle("Activities")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}


