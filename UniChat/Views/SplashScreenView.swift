//
//  SplashScreenView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/10.
//

import SwiftUI

struct SplashScreenView: View {
    
    // for splsh wait time
    @State var timeElapsed = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !timeElapsed {
                    logoSplash
                } else {
                    intro
                }
            }
            .onAppear {
                Task { @MainActor in
                    try await Task.sleep(for: .seconds(0))
                    timeElapsed = true
                }
            }
        }
    }
    
    var logoSplash: some View {
        VStack {
            Image("logoBrown")
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(UniChatColor.dimmedYellow)
    }
    
    var intro: some View {
        VStack {
            Spacer()
            TabView{
                slide1
                slide2
                slide3
                slide4
            }
            .padding(.bottom, -200)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear {
                  setupAppearance()
            }
        }
        .frame(maxWidth: .infinity)
        .background(UniChatColor.dimmedYellow)
    }
    
    var slide1: some View {
        VStack {
            VStack{
                Text("\"i don't know which \nuni suits me 😩\"")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
                
                Text("\"🧐 not sure which classes to enrol\"")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
                
                Text("\"where them chill lecturers go ... 🫥\"")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
            }
            .frame(width: 350, height: 400)
            .background(UniChatColor.babyblue)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.bottom, 70)
            
            Image("intro-1")
        }
    }
    
    var slide2: some View {
        VStack{
            VStack{
                Text("💬\nUniChat\nprovides a safe\nenvironment to\ndiscuss all your\nuni concerns")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
            }
            .frame(width: 350, height: 400)
            .background(UniChatColor.babyblue)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.bottom, 45)
            
            Image("intro-2")
        }
    }
    
    var slide3: some View {
        VStack{
            VStack{
                Text("🌟🌟🌟🌟🌟\nrate your uni and lecturers and share your thoughts\nanonymously")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
            }
            .frame(width: 350, height: 400)
            .background(UniChatColor.babyblue)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.bottom, 45)
            
            Image("intro-3")
        }
    }
    
    var slide4: some View {
        VStack {
            VStack{
                Text("join UniChat now \nand\nshare your own\nuni life\n😍")
                    .font(.title .bold())
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(UniChatColor.lightBrown)
            }
            .frame(width: 350, height: 400)
            .background(UniChatColor.babyblue)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.bottom, 40)
            
            
            
            NavigationLink (destination: LogInView()) {
                Text("Log in / Sign up Now")
                    .font(.title2.bold())
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(UniChatColor.brightYellow)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 80)
            
            Image("logoBrown")
        }
        .padding(.bottom, 60)
    }
    
    private func splashDelay() async {
        try? await Task.sleep(nanoseconds: 7_500_000_000)
        timeElapsed = true
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .secondaryLabel
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.secondaryLabel.withAlphaComponent(0.2)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
