---
name: {{skill-name}}
description: {{Clear description of what this skill does and when to use it. Be specific about triggers and use cases. Should be >50 characters.}}
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: {{category}}
requires: []
env: []
argument-hint: "{{usage hint}}"
---

# {{Skill Name}}

{{Brief 2-3 sentence description of what this skill does and the problem it solves.}}

## Overview

{{Expanded description with context on why this skill is useful.}}

**Keywords**: {{keyword1}}, {{keyword2}}, {{keyword3}}

## Prerequisites

{{List any requirements: API keys, tools, file access, etc. Or state:}}

None - works natively with any AI coding agent.

## Personalization (Optional)

If `user/context.md` exists in this skill folder, load it for personalized outputs.

To personalize:
1. Copy `user/context.md.template` to `user/context.md`
2. Fill in your details
3. The skill will automatically use your context

## How to Use

### Step 1: {{First Step Name}}

{{Detailed instructions for the first step}}

### Step 2: {{Second Step Name}}

{{Detailed instructions for the second step}}

### Step 3: {{Third Step Name}}

{{Detailed instructions for the third step}}

---

## Workflow

### 1. {{Phase Name}}
{{Description of what happens in this phase}}

### 2. {{Phase Name}}
{{Description of what happens in this phase}}

### 3. {{Phase Name}}
{{Description of what happens in this phase}}

---

## Output Format

{{Describe the expected output format. If writing to a file:}}

Write output to: `{{output-path}}`

Use this structure:

```markdown
{{output template}}
```

---

## Example

**Input:**
```
{{example input}}
```

**Output:**
```
{{example output}}
```

---

## Guidelines

- {{Guideline 1}}
- {{Guideline 2}}
- {{Guideline 3}}
- {{Guideline 4}}

## Troubleshooting

| Issue | Solution |
|-------|----------|
| {{Common issue 1}} | {{Solution 1}} |
| {{Common issue 2}} | {{Solution 2}} |
| {{Common issue 3}} | {{Solution 3}} |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | {{YYYY-MM-DD}} | Initial release |
