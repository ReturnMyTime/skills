---
name: quick-reply
description: Draft professional email replies in seconds. Provide an email thread and get 2-3 reply options with different tones (professional, friendly, direct). Use when you need to respond to emails quickly without sacrificing quality.
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: productivity
requires: []
env: []
argument-hint: "[paste email or path to email file]"
---

# Quick Reply

Draft professional email replies instantly with multiple tone options.

## Overview

Save time on email responses by generating 2-3 polished reply options. Each option uses a different tone so you can pick the one that fits the situation.

**Keywords**: email, reply, draft, communication, productivity

## Prerequisites

None - works natively with any AI coding agent.

## Personalization (Optional)

If `user/context.md` exists in this skill folder, load it for personalized outputs that match your communication style and include relevant context about your role/company.

To personalize:
1. Copy `user/context.md.template` to `user/context.md`
2. Fill in your details
3. Replies will automatically reflect your context

## How to Use

### Step 1: Provide the Email

Paste the email thread or provide a path to an email file. Include:
- The original message you're replying to
- Any relevant thread history
- (Optional) What you want to convey

### Step 2: Review Generated Options

You'll receive 2-3 reply options:

| Option | Tone | Best For |
|--------|------|----------|
| **A** | Professional | Formal contexts, new contacts, sensitive topics |
| **B** | Friendly | Colleagues, ongoing relationships, positive news |
| **C** | Direct | Busy recipients, simple requests, follow-ups |

### Step 3: Select and Send

Pick the option that fits, make any tweaks, and send.

---

## Workflow

### 1. Analyze the Email
- Identify the sender and their relationship to you
- Determine the purpose (request, question, FYI, complaint)
- Note the sender's tone and formality level
- Extract key points that need addressing

### 2. Check for Context
- Load `user/context.md` if present
- Apply user's communication preferences
- Include relevant role/company context

### 3. Generate Reply Options

For each option, include:
- Appropriate greeting
- Direct response to main points
- Any necessary action items or next steps
- Professional sign-off

### 4. Present Options

Format output as:

```markdown
## Option A: Professional
[Full reply text, ready to send]

---

## Option B: Friendly  
[Full reply text, ready to send]

---

## Option C: Direct
[Full reply text, ready to send]
```

---

## Guidelines

- Match reply length to the original email's complexity
- Address all questions or requests in the original
- Avoid jargon unless the sender used it
- Include a clear call-to-action when appropriate
- Keep each option distinct in tone, not just word choice

## Example

**Input:**
```
From: Sarah Chen <sarah@acmecorp.com>
Subject: Re: Project Timeline

Hi,

Thanks for sending over the proposal. The team reviewed it yesterday and we have a few questions:

1. Can you clarify the deliverables for Phase 2?
2. Is the April 15th deadline flexible?
3. Who will be our main point of contact?

Looking forward to your response.

Best,
Sarah
```

**Output:**

## Option A: Professional
```
Hi Sarah,

Thank you for the team's review and thoughtful questions. I'm happy to clarify:

1. Phase 2 deliverables include the complete UI redesign, API integration documentation, and user acceptance testing protocols. I can send a detailed breakdown if helpful.

2. The April 15th deadline has some flexibility. If needed, we could extend to April 22nd without impacting subsequent phases.

3. I'll be your primary point of contact throughout the project, with [Name] as backup for technical questions.

Please let me know if you'd like to schedule a call to discuss any of these in more detail.

Best regards,
[Your name]
```

## Option B: Friendly
```
Hi Sarah!

Great questions - thanks for taking the time to review everything with the team.

Here's the scoop:

1. Phase 2 is all about the UI redesign, API docs, and getting UAT set up. Happy to walk through the details anytime!

2. April 15th has a bit of wiggle room - we could push to the 22nd if that works better for your team.

3. You've got me! I'll be your go-to for everything, and [Name] can jump in on any technical deep-dives.

Want to hop on a quick call this week to chat through anything else?

Cheers,
[Your name]
```

## Option C: Direct
```
Hi Sarah,

Answers to your questions:

1. Phase 2: UI redesign, API documentation, UAT protocols
2. April 15th: Flexible up to April 22nd
3. Point of contact: Me (primary), [Name] (technical backup)

Let me know if you need anything else.

[Your name]
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Replies are too long | Ask for "concise" or "brief" versions |
| Tone doesn't match | Specify the relationship (e.g., "this is my boss") |
| Missing context | Add more thread history or explain the situation |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-02 | Initial release |
