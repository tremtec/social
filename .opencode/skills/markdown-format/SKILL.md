---
name: markdown-format
description: Markdown formatting and linting best practices for documentation files
license: MIT
compatibility: opencode
metadata:
  scope: documentation
  category: formatting
---

## What I do

Ensure Markdown files are properly formatted, linted, and follow best practices for readability and consistency.

## When to use me

- Creating or editing Markdown documentation
- Formatting README files
- Writing AGENTS.md or SKILL.md files
- Preparing documentation for PRs

## Rules

### File Structure

1. **Use proper heading hierarchy** - start with H1, don't skip levels:

   ```markdown
   # Main Title

   ## Section

   ### Subsection
   ```

2. **Add blank lines** around headers, lists, code blocks, and paragraphs:

   ```markdown
   ## Section

   Paragraph text here.

   - List item 1
   - List item 2

   ## Next Section
   ```

3. **Code blocks** should specify language:
   ````markdown
   ```elixir
   def hello do
     "world"
   end
   ```
   ````
   ```

   ```

### Formatting

1. **Line length**: Keep lines under 100 characters for readability

2. **Lists**:
   - Use `-` for unordered lists
   - Use `1.` for ordered lists
   - Indent sub-items with 2 spaces

3. **Emphasis**:
   - Use `**bold**` for strong emphasis
   - Use `*italic*` for light emphasis
   - Use `` `code` `` for inline code

4. **Links**:
   - Use `[text](url)` format
   - Prefer reference-style links for repeated URLs:

     ```markdown
     [Elixir][elixir-home] is great.

     [elixir-home]: https://elixir-lang.org
     ```

### AGENTS.md / SKILL.md Specific

1. **SKILL.md must have frontmatter**:

   ```markdown
   ---
   name: skill-name
   description: Brief description here
   license: MIT
   compatibility: opencode
   metadata:
     key: value
   ---
   ```

2. **Use sections**: What I do, When to use me, Rules, Key Files

3. **Name requirements**:
   - 1-64 characters
   - Lowercase alphanumeric with hyphens
   - Must match directory name

4. **Description**: 1-1024 characters, clear and specific

### Linting

Run these commands when done:

```bash
# Check formatting
mix format

# Run precommit checks (includes formatting)
mix precommit
```

## Common Patterns

### Code Examples

Use fenced code blocks with language identifier:

````markdown
```elixir
defmodule MyModule do
  def hello do
    "world"
  end
end
```
````

````

### Tables

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
````

### Blockquotes

```markdown
> This is a blockquote.
> It can span multiple lines.
```

## Key Files

- `README.md` - Project overview
- `AGENTS.md` - Project guidelines for OpenCode
- `.opencode/skills/*/SKILL.md` - Skill definitions
- `CHANGELOG.md` - Version history

## Best Practices

- Write clear, concise documentation
- Use examples to illustrate concepts
- Keep headings descriptive
- Maintain consistent formatting throughout
- Preview rendered output when possible
- Use spell check before committing
