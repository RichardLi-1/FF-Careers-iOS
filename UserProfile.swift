//
//  UserProfile.swift
//  FF Careers
//
//  Created by Richard Li on 2024-12-13.
//

import Foundation

struct TaskFeedback: Codable {
    let taskTitle: String
    let enjoymentRating: Int?       // Star rating (e.g., 1-5)
    let motivationRating: Int?       // Star rating (e.g., 1-5)
    let problemSolvingRating: Int?       // Star rating (e.g., 1-5)
    let lifestyleRating: Int?       // Star rating (e.g., 1-5)
    let valueRating: Int?       // Star rating (e.g., 1-5)
    let feedback: String?  // Optional text-based feedback
    let feedbackPrompt: String?
}
