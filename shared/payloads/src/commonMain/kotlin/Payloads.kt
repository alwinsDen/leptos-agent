package com.alwinsden

import kotlinx.serialization.Serializable

@Serializable
data class ConversationSubmitRequest(
    val model: String,
    val prompt: String,
    val conversationId: String? = null
)

@Serializable
data class ConversationSubmitResponse(
    val conversationId: String,
    val message: String
)
