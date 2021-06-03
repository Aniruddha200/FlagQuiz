//
//  ContentView.swift
//  FlagQuiz
//
//  Created by administrator on 29/05/2021.
//

import SwiftUI

// Custom Modifier

struct CapsuleStyle: ViewModifier{
	func body(content: Content) -> some View {
		content
			.clipShape(Capsule())
			.overlay(
				Capsule()
					.stroke(Color.black, lineWidth: 2.0)
			)
			.shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 3.0, y: -5.0)
	}
}

extension View{
	func prettyButton()-> some View{
		self.modifier(CapsuleStyle())
	}
}


// Custom View

struct CapsuleButton: View {
	var indexNum: Int
	var flagImage: Image
	var action: (_:Int) -> Void
	var body: some View{
		Button(action: {self.action(indexNum)}){
			self.flagImage
		}
		.prettyButton()
		
	}
}

struct ContentView: View {
	@State private var flags = ["Estonia", "France", "Germany", "Nigeria", "UK"]
	@State private var qFlag = "Estonia"
	@State private var bResult = false
	@State private var score = 0
    var body: some View {
		ZStack{
			LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
			VStack(spacing: 20){
				Spacer(minLength: 10)
				Text("Guess the flag of")
					.foregroundColor(.white)
				Text("\(self.qFlag)")
					.foregroundColor(.white)
					.fontWeight(.black)
					.font(.title)
				Text("\(self.score)")
					.foregroundColor(.white)
					.fontWeight(.black)
					.font(.title)
				Spacer(minLength: 20)
				VStack(spacing: 30){
					ForEach (0..<3){ num in
						CapsuleButton(indexNum: num, flagImage: Image(flags[num])) { num in
							self.tapResult(num)
						}
						
						
				}
					Spacer()
					Button(action: {
						self.score = 0
						self.flags.shuffle()
						self.qFlag = self.flags[Int.random(in: 0...2)]
						
						
					}){
						ZStack{
							RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))]), center: .topLeading, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
							Text("Restart")
								.font(.title)
								.fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
								.foregroundColor(.white)
						}
					}
					.frame(width: 200, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
					.cornerRadius(40)
					.padding(10)
					.overlay(Capsule().stroke(Color.white, lineWidth: 2.0))
			}
		}
	}
	}
	
	func tapResult(_ number:Int){
		if flags[number] == self.qFlag{
			self.score += 1
		}
		self.flags.shuffle()
		self.qFlag = self.flags[Int.random(in: 0...2)]
		
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
