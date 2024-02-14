//
//  AccountView.swift
//  fitr5
//
//  Created by Craig Sochocki on 1/19/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Spacer()
                LifetimeMetricsView()
                if let userProfile = viewModel.userProfile {
                    AthleteAttributesView(profile: userProfile)
                }
                
            }.navigationTitle(viewModel.userProfile?.name ?? "Profile")
        }
        
    }
}

struct LifetimeMetricsView: View {
    var body: some View {
        HStack {
            Spacer()
            Circle()
                .frame(width: 75, height: 75)
                .foregroundColor(Color("AccentColor"))
                .overlay(
                    Text("CS")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold))
            Spacer()
            VStack {
                Text("20")
                    .fontWeight(.bold
                )
                Text("sessions")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("2000")
                    .fontWeight(.bold)
                Text("Volume (lb)")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("100")
                    .fontWeight(.bold)
                Text("Reps")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct AthleteAttributesView: View {
    let profile: Profile
    
    var body: some View {
        List {
            HStack {
                Text("Age")
                Spacer()
                Text("\(profile.age)")
            }
            HStack {
                Text("Weight")
                Spacer()
//            TODO: Link this with logged weights
                Text("\(profile.weight) pounds")
            }
            HStack {
                Text("Current Program")
                Spacer()
                Text("MAPS Starter")
            }
        }
    }
}


#Preview {
    ProfileView(viewModel: UserProfileViewModel())
}
