//
//  Conversation.swift
//  UntitledAI
//
//  Created by ethan on 1/23/24.
//

import Foundation

struct ConversationsResponse: Codable {
    var conversations: [Conversation]
//    var conversationsInProgress: [ConversationProgress]

    enum CodingKeys: String, CodingKey {
        case conversations
//        case conversationsInProgress = "conversations_in_progress"
    }
}

enum ConversationState: String, Codable {
    case capturing = "CAPTURING"
    case processing = "PROCESSING"
    case completed = "COMPLETED"
    case failedProcessing = "FAILED_PROCESSING"
}

struct Conversation: Codable {
    var id: Int
    var startTime: Date
    var endTime: Date?
    var conversationUUID: String
    var captureFileSegment: CaptureFileSegment
    var deviceType: String
    var summary: String?
    var summarizationModel: String?
    var shortSummary: String?
    var state: ConversationState
    var transcriptions: [Transcription]
    var primaryLocation: Location?

    enum CodingKeys: String, CodingKey {
        case id
        case startTime = "start_time"
        case endTime = "end_time"
        case conversationUUID = "conversation_uuid"
        case deviceType = "device_type"
        case summary
        case captureFileSegment = "capture_segment_file"
        case shortSummary = "short_summary"
        case summarizationModel = "summarization_model"
        case state
        case transcriptions
        case primaryLocation = "primary_location"
    }
    var realtimeTranscript: Transcription? {
        transcriptions.first(where: { $0.realtime == true })
    }

    var finalTranscript: Transcription? {
        transcriptions.first(where: { $0.realtime == false })
    }
}

struct ConversationProgress: Codable {
    var conversationUUID: String
    var inConversation: Bool
    var startTime: Date
    var endTime: Date
    var deviceType: String

    enum CodingKeys: String, CodingKey {
        case conversationUUID = "conversation_uuid"
        case inConversation = "in_conversation"
        case startTime = "start_time"
        case endTime = "end_time"
        case deviceType = "device_type"
    }
}
