# Ultimate Hub Wiki Content

This directory contains all the wiki pages for the Ultimate Hub (Huckr) project.

## Wiki Structure

1. **Home.md** - Landing page with project overview and navigation
2. **Getting-Started.md** - Installation and setup guide
3. **Architecture.md** - Clean Architecture implementation details
4. **Development-Guide.md** - Daily development workflow and conventions
5. **Ultimate-Frisbee-Rules.md** - Sport-specific knowledge and rules
6. **Features.md** - Feature documentation across all phases
7. **Design-System.md** - Golden Hour theme and UI guidelines
8. **Database-Schema.md** - Supabase and Hive schema documentation
9. **Testing-Strategy.md** - Testing approach and examples
10. **Contributing.md** - Contribution guidelines

## How to Add These Pages to GitHub Wiki

GitHub wikis are separate git repositories. Here's how to set it up:

### Method 1: GitHub Web Interface (Recommended for First Page)

1. Go to https://github.com/CalebTB/Huckr/wiki
2. Click "Create the first page"
3. Copy the content from `Home.md` into the editor
4. Click "Save Page"

This initializes the wiki repository.

### Method 2: Git Clone (For All Pages)

After creating the first page via the web interface:

```bash
# Clone the wiki repository
cd /Users/calebbyers/Code/ultimate
git clone https://github.com/CalebTB/Huckr.wiki.git

# Copy all wiki content
cp wiki-content/*.md Huckr.wiki/

# Commit and push
cd Huckr.wiki
git add .
git commit -m "docs: add comprehensive wiki documentation"
git push origin master
```

### Method 3: Manual Upload (One by One)

1. Go to https://github.com/CalebTB/Huckr/wiki
2. Click "New Page" for each file
3. Set the page title (e.g., "Getting Started" for Getting-Started.md)
4. Copy the content from the corresponding .md file
5. Click "Save Page"

**Page Titles to Use**:
- Home → "Home"
- Getting-Started.md → "Getting Started"
- Architecture.md → "Architecture"
- Development-Guide.md → "Development Guide"
- Ultimate-Frisbee-Rules.md → "Ultimate Frisbee Rules"
- Features.md → "Features"
- Design-System.md → "Design System"
- Database-Schema.md → "Database Schema"
- Testing-Strategy.md → "Testing Strategy"
- Contributing.md → "Contributing"

## Maintaining the Wiki

### Updating Pages

```bash
# Clone wiki repository (if not already cloned)
git clone https://github.com/CalebTB/Huckr.wiki.git

# Make changes to markdown files
cd Huckr.wiki
vim Getting-Started.md  # or use any editor

# Commit and push
git add Getting-Started.md
git commit -m "docs: update Flutter installation instructions"
git push origin master
```

### Adding New Pages

1. Create a new `.md` file in the wiki repository
2. Add links to the new page from relevant existing pages (especially Home.md)
3. Commit and push

### Linking Between Pages

Use relative links without the `.md` extension:

```markdown
See the [Architecture](Architecture) guide for details.
Check [Getting Started](Getting-Started) for setup.
```

## Wiki Organization Best Practices

1. **Keep Home.md as the hub** - Link to all major pages from Home
2. **Cross-reference pages** - Link related pages to each other
3. **Update regularly** - Keep wiki in sync with code changes
4. **Use clear headings** - Makes pages scannable
5. **Add code examples** - Show, don't just tell
6. **Include images** - Upload to wiki or use relative paths

## Sidebar Navigation

GitHub wikis support a sidebar. Create `_Sidebar.md`:

```markdown
**Ultimate Hub Wiki**

* [Home](Home)
* [Getting Started](Getting-Started)
* [Architecture](Architecture)
* [Development Guide](Development-Guide)

**Reference**
* [Ultimate Frisbee Rules](Ultimate-Frisbee-Rules)
* [Features](Features)
* [Design System](Design-System)
* [Database Schema](Database-Schema)

**Contributing**
* [Testing Strategy](Testing-Strategy)
* [Contributing](Contributing)
```

## Footer

Create `_Footer.md` for consistent footer across all pages:

```markdown
---
**Ultimate Hub** | [GitHub](https://github.com/CalebTB/Huckr) | [Report Issue](https://github.com/CalebTB/Huckr/issues) | [Discussions](https://github.com/CalebTB/Huckr/discussions)
```

## Next Steps

1. Initialize the wiki by creating the Home page via GitHub web interface
2. Clone the wiki repository
3. Copy all pages from this directory
4. Add sidebar and footer
5. Push all changes
6. Verify all internal links work
7. Share the wiki URL: https://github.com/CalebTB/Huckr/wiki

## Quick Start Commands

```bash
# After creating first page via web interface:
cd /Users/calebbyers/Code/ultimate

# Clone wiki repo
git clone https://github.com/CalebTB/Huckr.wiki.git

# Copy all pages
cp wiki-content/*.md Huckr.wiki/

# Optional: Add sidebar
cat > Huckr.wiki/_Sidebar.md << 'EOF'
**Ultimate Hub Wiki**

* [Home](Home)
* [Getting Started](Getting-Started)
* [Architecture](Architecture)
* [Development Guide](Development-Guide)

**Reference**
* [Ultimate Frisbee Rules](Ultimate-Frisbee-Rules)
* [Features](Features)
* [Design System](Design-System)
* [Database Schema](Database-Schema)

**Contributing**
* [Testing Strategy](Testing-Strategy)
* [Contributing](Contributing)
EOF

# Commit and push
cd Huckr.wiki
git add .
git commit -m "docs: add comprehensive wiki documentation

- Home page with project overview
- Getting Started guide
- Architecture documentation
- Development workflow guide
- Ultimate Frisbee rules reference
- Feature documentation
- Design system (Golden Hour theme)
- Database schema (Hive + Supabase)
- Testing strategy and examples
- Contributing guidelines
- Sidebar navigation"

git push origin master

echo "Wiki published! View at: https://github.com/CalebTB/Huckr/wiki"
```
