package com.alwinsden.liptosagent

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform