# Luis Scheibe: Portfolio website

A personal portfolio site styled after Kian Maher's (kimaher.github.io/Kian-sWebsite): white page, Arial, name + round photo +
gray buttons on the left, and big headings with an underline on the right. The only extra touch is Cal Poly green (`--green` in
`styles.css`) on the heading lines, the selected button, the photo ring and the project numbers and links.

The About / Experience / Projects buttons switch the right-hand content (the `.view` blocks in `index.html`). Resume, LinkedIn and GitHub
open in a new tab. It's plain HTML, CSS and JavaScript with no build step. On phones the two columns stack.

Live at **https://luisscheibe9-git.github.io** (GitHub Pages, published 2026-09-28 from repo luisscheibe9-git/luisscheibe9-git.github.io). Any push to `main` updates the site within about a minute.

## Files
| Path | What it is |
|---|---|
| `index.html` | All page content. Edit the text here |
| `styles.css` | Styling. The accent color is `--green` at the top (Cal Poly green `#154734`) |
| `script.js` | Makes the buttons switch between About, Experience and Projects |
| `assets/img/` | Images. `profile.jpg` is the headshot (square crop of the LinkedIn photo) |
| `assets/Luis_Scheibe_Resume.pdf` | Copy of the resume **with the phone number removed** (made from `Desktop\work\job\Luis_Scheibe_Resume.docx`, the Sept 28, 2026 version) |
| `tools/preview.js` | Local preview: `node tools\preview.js`, then open http://localhost:5500 |

Content comes from the resume and `Luis_Scheibe_Portfolio_1pg.pptx` in `Desktop\work\job`, plus the live GitHub projects.

## Before publishing (checklist)
- [x] **Profile photo** added.
- [x] **Phone number removed** from the published resume PDF.
- [x] **Voliro CAD renders and lab photo removed** until they're approved (2026-09-28). The originals are in
      `Desktop\work\job\Luis_Scheibe_Portfolio_1pg.pptx`. Once approved, put them back in `assets/img/` and add `<img>` tags in the
      `.photos` block of the Voliro project.
- [ ] **Voliro drone photo** (`voliro-t-drone.jpg`) is kept. It looks like Voliro's own marketing photo, so a quick OK from them is still worth getting.
## Updating the resume
Copy the new PDF over `assets\Luis_Scheibe_Resume.pdf` (keep the same filename), then commit and push.
