//
//  SummerView.swift
//  Ecom
//
//  Created by Vineet Rai on 20-Sep-25.
//

import SwiftUI

struct SummerView: View {
    @StateObject private var viewModel = SummerViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    GradientPalette.headerGradient
                        .ignoresSafeArea()
                        .frame(height: 400)
                    Spacer()
                }
                VStack(spacing: 0) { HStack { Spacer() }
                    Color.pink.opacity(0.1)
                    Spacer()
                }
                .background(.white)
                .padding(.top, 250)
                VStack(spacing: 0) {
                    headerView
                    
                    Spacer().frame(height: 60)
                    contentView
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
        }
        .onAppear {
            viewModel.loadSummerItems()
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Summer")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 12)
                
                Text("\(viewModel.getItemCount()) Wardrobes")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                loadingView
            } else {
                wardrobeItemsList
            }
            
            bottomNavigationView
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading...")
                .font(.headline)
                .padding(.top, 10)
            Spacer()
        }
    }
    
    private var wardrobeItemsList: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.wardrobeItems) { item in
                    WardrobeItemCard(item: item) {
                        viewModel.shopItem(item)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
    }
    
    private var bottomNavigationView: some View {
        HStack(alignment: .center, spacing: 0) {
            NavigationButton(icon: "house", isSelected: false, image: nil)
            NavigationButton(icon: "magnifyingglass", isSelected: false, image: nil)
            NavigationButton(icon: "person.circle", isSelected: true, image: "1")
            NavigationButton(icon: "bell", isSelected: false, image: nil)
            NavigationButton(icon: "line.3.horizontal", isSelected: false, image: nil)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .padding(.horizontal, 20)
        .padding(.vertical, -10)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.3))
                .offset(y: -30)
        )
    }
}

struct WardrobeItemCard: View {
    let item: WardrobeItem
    let onShopTapped: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 12) {
                Spacer()
                    .frame(width: 100)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                    
                    Text("by \(item.brand)")
                        .font(.subheadline)
                        .foregroundColor(.pink)
                    
                    HStack(spacing: 4) {
                        StarRatingView(rating: item.rating, starSize: 12)
                        Spacer()
                    }
                    HStack {
                        Text("$\(Int(item.price))")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        ReusableButton(title: "Shop", style: .gradient) {
                            onShopTapped()
                        }
                    }
                }
                
                Spacer()
            }
            .padding(16)
            .background(
                ZStack {
                    CardBackgroundShape()
                        .fill(Color.pink.opacity(0.05))
                        .offset(x: 0, y: 10)
                    
                    CardShape()
                        .fill(Color.pink.opacity(0.10))
                        .offset(x: 0, y: 10)
                    
                    Rectangle()
                        .fill(Color.white)
                }
            )
            .shadow(color: Color.pink.opacity(0.2), radius: 6, x: 0, y: -3)
            .frame(height: 120)
            
            ReusableImageView(
                imageName: item.imageName,
                width: 100,
                height: 115,
                cornerRadius: 8
            )
            .offset(x: 16, y: -10)
            .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: -4)
        }
        .frame(height: 150)
    }
}

struct NavigationButton: View {
    let icon: String
    let isSelected: Bool
    let image: String?
    
    var body: some View {
        Button(action: {
        }) {
            if let image {
                Image(image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20, corners: .allCorners)
            } else {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .black : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct CardBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 30
        let backgroundOffset: CGFloat = 10
        
        let backgroundRect = CGRect(
            x: rect.minX - 16,
            y: rect.minY + backgroundOffset,
            width: rect.width + 30,
            height: rect.height - backgroundOffset + 20
        )
        path.addRoundedRect(
            in: backgroundRect,
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        return path
    }
}

struct CardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 30
        let shadowOffset: CGFloat = 10
        
        let shadowRect = CGRect(
            x: rect.minX,
            y: rect.minY + shadowOffset,
            width: rect.width,
            height: rect.height - shadowOffset
        )
        path.addRoundedRect(
            in: shadowRect,
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        return path
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    SummerView()
}
