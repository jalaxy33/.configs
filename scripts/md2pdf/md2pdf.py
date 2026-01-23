#!/usr/bin/env python3
"""
Convert Markdown to GitHub-styled PDF
"""
import markdown
from weasyprint import HTML, CSS
from pathlib import Path

# GitHub-style CSS
GITHUB_CSS = """
@page {
    margin: 2cm;
    size: A4;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
    font-size: 14px;
    line-height: 1.6;
    color: #24292f;
    background-color: #ffffff;
    max-width: 980px;
    margin: 0 auto;
    padding: 20px;
}

h1, h2, h3, h4, h5, h6 {
    margin-top: 24px;
    margin-bottom: 16px;
    font-weight: 600;
    line-height: 1.25;
}

h1 {
    font-size: 2em;
    padding-bottom: 0.3em;
    border-bottom: 1px solid #d0d7de;
}

h2 {
    font-size: 1.5em;
    padding-bottom: 0.3em;
    border-bottom: 1px solid #d0d7de;
}

h3 {
    font-size: 1.25em;
}

h4 {
    font-size: 1em;
}

h5 {
    font-size: 0.875em;
}

h6 {
    font-size: 0.85em;
    color: #57606a;
}

p {
    margin-top: 0;
    margin-bottom: 16px;
}

a {
    color: #0969da;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

ul, ol {
    margin-top: 0;
    margin-bottom: 16px;
    padding-left: 2em;
}

li + li {
    margin-top: 0.25em;
}

code {
    font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace;
    font-size: 85%;
    background-color: rgba(175, 184, 193, 0.2);
    padding: 0.2em 0.4em;
    border-radius: 6px;
}

pre {
    font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace;
    font-size: 85%;
    line-height: 1.45;
    background-color: #f6f8fa;
    border-radius: 6px;
    padding: 16px;
    overflow: auto;
    margin-bottom: 16px;
}

pre code {
    background-color: transparent;
    padding: 0;
    border-radius: 0;
}

blockquote {
    margin: 0 0 16px 0;
    padding: 0 1em;
    color: #57606a;
    border-left: 0.25em solid #d0d7de;
}

blockquote > :first-child {
    margin-top: 0;
}

blockquote > :last-child {
    margin-bottom: 0;
}

hr {
    height: 0.25em;
    padding: 0;
    margin: 24px 0;
    background-color: #d0d7de;
    border: 0;
}

table {
    border-spacing: 0;
    border-collapse: collapse;
    margin-top: 0;
    margin-bottom: 16px;
}

table th {
    font-weight: 600;
    padding: 6px 13px;
    border: 1px solid #d0d7de;
    background-color: #f6f8fa;
}

table td {
    padding: 6px 13px;
    border: 1px solid #d0d7de;
}

table tr {
    background-color: #ffffff;
    border-top: 1px solid #d0d7de;
}

table tr:nth-child(2n) {
    background-color: #f6f8fa;
}

img {
    max-width: 100%;
    box-sizing: content-box;
}

strong {
    font-weight: 600;
}

em {
    font-style: italic;
}
"""

def convert_md_to_pdf(md_file, output_pdf=None):
    """
    Convert Markdown file to GitHub-styled PDF

    Args:
        md_file: Path to markdown file
        output_pdf: Output PDF path (optional, defaults to same name as md_file)
    """
    md_path = Path(md_file)

    if not md_path.exists():
        raise FileNotFoundError(f"Markdown file not found: {md_file}")

    # Read markdown content
    with open(md_path, 'r', encoding='utf-8') as f:
        md_content = f.read()

    # Convert markdown to HTML with extensions
    md_extensions = [
        'markdown.extensions.fenced_code',
        'markdown.extensions.tables',
        'markdown.extensions.nl2br',
        'markdown.extensions.sane_lists',
        'markdown.extensions.codehilite',
        'markdown.extensions.toc',
    ]

    html_content = markdown.markdown(md_content, extensions=md_extensions)

    # Wrap in HTML structure
    full_html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
    </head>
    <body>
        {html_content}
    </body>
    </html>
    """

    # Determine output path
    if output_pdf is None:
        output_pdf = md_path.with_suffix('.pdf')

    # Convert to PDF with GitHub CSS
    HTML(string=full_html).write_pdf(
        output_pdf,
        stylesheets=[CSS(string=GITHUB_CSS)]
    )

    print(f"✓ PDF created: {output_pdf}")
    return output_pdf


if __name__ == "__main__":
    # Convert the AI tools markdown file
    md_file = "YOUR-MD.md"
    convert_md_to_pdf(md_file)

