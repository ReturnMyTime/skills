---
name: meeting-prep
description: Generate comprehensive meeting briefings with attendee research, agenda suggestions, talking points, and follow-up templates. Use before any important meeting to show up prepared and make a strong impression.
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
argument-hint: "[meeting topic] [attendee names/companies] [--date <date>]"
---

# Meeting Prep

Generate comprehensive meeting briefings to show up prepared every time.

## Overview

Transform scattered meeting details into a polished briefing document. Get attendee profiles, agenda suggestions, talking points, questions to ask, and a follow-up template—all in minutes.

**Keywords**: meeting, preparation, briefing, agenda, productivity

## Prerequisites

None - works natively. For enhanced attendee research, web search capabilities improve results.

## Personalization (Optional)

If `user/context.md` exists, briefings will include context about your role, company, and meeting preferences.

To personalize:
1. Copy `user/context.md.template` to `user/context.md`
2. Fill in your details
3. Briefings will reflect your context and goals

## How to Use

### Step 1: Provide Meeting Details

Share what you know:
- Meeting topic or purpose
- Attendee names and/or companies
- Date and time (if relevant)
- Any existing agenda or context
- Your goals for the meeting

### Step 2: Review the Briefing

You'll receive a complete briefing document with:
- Attendee profiles
- Suggested agenda
- Talking points
- Questions to ask
- Follow-up template

### Step 3: Use and Customize

Take the briefing into your meeting. Add notes during, then use the follow-up template after.

---

## Workflow

### 1. Gather Context
- Parse provided meeting details
- Load `user/context.md` if present
- Identify information gaps

### 2. Research Attendees
For each attendee, compile:
- Name and title
- Company and role
- LinkedIn summary (if searchable)
- Recent news or accomplishments
- Potential connection points with you
- Communication style notes (if inferable)

### 3. Generate Agenda
Based on meeting purpose:
- Suggest time allocations
- Order topics by priority
- Include buffer for discussion
- Add specific decision points

### 4. Create Talking Points
- Key messages you want to convey
- Data points or examples to reference
- Objection handling (if applicable)
- Success metrics to mention

### 5. Prepare Questions
- Discovery questions (learn about them)
- Clarifying questions (ensure alignment)
- Strategic questions (guide toward your goals)
- Closing questions (confirm next steps)

### 6. Draft Follow-Up Template
- Thank you and recap
- Action items with owners
- Next steps and timeline
- Open items for future discussion

---

## Output Format

Write briefing to: `meeting-prep-[topic]-[date].md`

Use structure from `references/briefing-template.md`.

---

## Example

**Input:**
```
Meeting with Sarah Chen (VP Product at Acme Corp) and Mike Torres (CTO)
Topic: Partnership discussion for API integration
Date: Feb 15, 2026
My goal: Get commitment to pilot program
```

**Output:**

```markdown
# Meeting Briefing: Acme Corp Partnership Discussion
**Date:** February 15, 2026
**Prepared for:** [Your name]

---

## Attendees

### Sarah Chen
- **Title:** VP Product, Acme Corp
- **Background:** 8 years in product management, previously at Stripe
- **LinkedIn:** Product-led growth advocate, speaks at SaaStr
- **Recent:** Launched Acme's new enterprise tier (Jan 2026)
- **Connection Point:** Both focused on developer experience

### Mike Torres  
- **Title:** CTO, Acme Corp
- **Background:** Engineering leader, ex-Google
- **LinkedIn:** Posts about API design and scalability
- **Recent:** Acme raised Series C ($45M) in Dec 2025
- **Connection Point:** Technical depth, appreciates specifics

---

## Suggested Agenda (45 min)

| Time | Topic | Owner |
|------|-------|-------|
| 0:00 | Introductions & context | All |
| 0:05 | Their API integration needs | Sarah |
| 0:15 | Our solution overview | You |
| 0:25 | Technical deep-dive | Mike + You |
| 0:35 | Pilot program proposal | You |
| 0:40 | Next steps & timeline | All |

---

## Your Talking Points

1. **Value prop:** "Our API reduces integration time from weeks to days"
2. **Social proof:** "Similar to what we did with [Company X]"
3. **Pilot specifics:** "30-day pilot, 2 engineer hours, full support"
4. **Urgency:** "Q1 pricing available through March"

---

## Questions to Ask

**Discovery:**
- "What's driving the timeline for this integration?"
- "How does your team currently handle [X]?"

**Strategic:**
- "If we could solve [problem], what would that unlock for you?"
- "Who else would need to be involved in a pilot decision?"

**Closing:**
- "What would you need to see to move forward with a pilot?"
- "Can we get a pilot kicked off by end of month?"

---

## Follow-Up Template

Subject: Next steps from our conversation

Hi Sarah and Mike,

Thanks for taking the time to meet today. I enjoyed learning about [specific thing discussed].

**Key Takeaways:**
- [Recap point 1]
- [Recap point 2]

**Action Items:**
- [ ] [You]: Send technical documentation by [date]
- [ ] [Them]: Review with engineering team
- [ ] [All]: Pilot kickoff call on [date]

Looking forward to the next steps. Let me know if any questions come up.

Best,
[Your name]
```

---

## Guidelines

- Research is only as good as available public information
- Prioritize relevance over comprehensiveness
- Flag any assumptions or gaps in knowledge
- Tailor formality to the meeting context
- Keep briefings scannable (bullets > paragraphs)

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Can't find attendee info | Ask user for LinkedIn URLs or more context |
| Agenda feels generic | Ask about specific meeting goals |
| Too much information | Request "executive summary" version |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-02 | Initial release |
