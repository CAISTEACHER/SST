# CAIS - Student Support Tool

Standalone static web app for GitHub Pages that renders a live, filterable responsibility matrix from a public Google Sheet CSV feed.

## Files

- `index.html` - complete app with HTML, CSS, and JavaScript
- `start.command` - optional local preview launcher for macOS
- `config.example.js` - example local config for preloading the OpenAI key

## Features

- Live Google Sheet CSV sync with polling, sync state, and last-updated timestamp
- Matrix sorted by Tier, then Category, then Accommodation
- Collapsible filters for people and categories, plus task search
- Sticky Category and Accommodations columns with a scrollable matrix
- Automatic hiding of unused people columns in the current filtered view
- Selected people move to the front and their assigned cells highlight light green
- Print-friendly PDF export for the current view
- Combined `Export All` print view with one page per person
- Teacher lesson-plan helper that sends the current visible accommodations and the sheet’s `How to Implement` text to the OpenAI Responses API

## Google Sheet

The app is already configured for this sheet:

- [CAIS Google Sheet](https://docs.google.com/spreadsheets/d/1RoLssQ-nroFQagu_OKNajmTlfEsryqY8DfB-4ZW0Ork/view?usp=sharing)

It expects:

- `Tier`
- `Category` or `Category`
- `Accommodation` or `Accommodation`
- optional `Type`
- optional `Notes`
- optional `How to Implement`
- all remaining columns treated as people

## Local preview

Double-click `start.command`, or run:

```bash
python3 -m http.server 8000
```

Then open:

```text
http://localhost:8000
```

Do not open `index.html` directly from Finder if you want live Google Sheet sync. Opened as a `file://` page, many browsers block the remote sheet requests. `start.command` avoids that by serving the folder over `http://localhost:8000` and opening the app for you.

## Optional local API key file

If you do not want to type the API key into the app each time, create a local file named `config.local.js` in this folder.

Start from `config.example.js` and make it:

```js
window.APP_CONFIG = {
  OPENAI_API_KEY: "sk-your-key-here",
  OPENAI_MODEL: "gpt-5.4"
};
```

`config.local.js` is ignored by the local `.gitignore` in this folder.

## GitHub Pages

1. Put the contents of this `SST` folder in a GitHub repository.
2. Enable GitHub Pages for the repository.
3. Publish from the branch/folder that contains `index.html`.

## OpenAI note

The lesson-plan assistant is fully static, so it calls the OpenAI API directly from the browser. That keeps the project GitHub Pages compatible, but it also means:

- users should use their own API key
- the key is stored only in that browser’s local storage
- there is no server-side secret protection in this version
- if `config.local.js` is deployed to GitHub Pages, the key will be public

For a school-wide deployment, a small backend proxy would be safer.

## Sync troubleshooting

The app now tries several Google Sheets public CSV endpoints. If sync still fails in the browser, make sure the sheet is one of these:

- shared as “Anyone with the link can view”
- or published to the web from Google Sheets
