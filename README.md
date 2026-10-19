# Insightly — local and public deployment build

## Run locally on Windows
1. Extract the ZIP into a normal folder (not inside the ZIP preview).
2. Double-click `START-INSIGHTLY.bat`.
3. When Notepad opens `.env`, paste your Gemini API key after `GEMINI_API_KEY=`. Do not share the key.
4. Save and close Notepad. Wait for dependencies to install and the server to start.
5. Open http://localhost:3000 in Chrome. Keep the black server window open while using Insightly.

The script creates `.env` from `.env.example` only when `.env` is missing. It does not overwrite an existing `.env`. Never upload or share `.env`.

## Deploy publicly with GitHub + Render
1. Create a new **private** GitHub repository (recommended while developing).
2. Extract this ZIP. Upload the contents of the `insightly-ready` folder to the repository root. Ensure `server.js`, `package.json`, `render.yaml`, `public/`, and `examples/` are at the root.
3. Confirm `.env` is NOT in GitHub. `.gitignore` excludes it. Never commit an API key.
4. In Render, choose **New + → Blueprint** and connect the repository containing `render.yaml`.
5. When prompted, enter `GEMINI_API_KEY` as a secret environment variable. Paste your own Gemini API key into Render's environment settings only; never into `public/index.html`, GitHub, or chat.
6. Deploy. Render should run `npm install`, then `npm start`, and check `/api/health`.
7. Open the public `onrender.com` URL. Test `/api/health` first; it should return `{"ok":true,"service":"insightly-api"}`. Then upload the sample CSV and test chart and AI commands.

## Sample data
Upload `examples/sample-students.csv`, then try:
- `Make a bar chart comparing each student across subjects`
- `Make a bar chart of average marks per subject`
- `Rank all students by total marks`
- `Find the topper in each subject`
- `Find students below 40 in any subject`
- `Calculate total marks and percentage for every student`

For percentage calculations, Insightly assumes each numeric subject is out of 100. Change the prompt if your maximum marks differ.

## Notes and limits
- `render.yaml` configures a Render Node web service and requests the Gemini API key as a secret. You still must create/connect the GitHub repository and deploy from your account; this ZIP alone does not publish the site.
- Render's free service may sleep when idle and can take time to wake up. Free plan availability and terms can change.
- The API is rate-limited to 10 requests per minute per client IP, but this is not a full authentication system. Anyone who discovers the public URL may be able to use the AI endpoint within the limit, potentially consuming your API quota. For a widely shared production app, add user authentication and stronger abuse protection before sharing publicly.
- AI responses require a valid Gemini API key, internet access, and available API quota. No API key is included in this ZIP.
- Image OCR is not connected. CSV, TSV, Excel, JSON, TXT and text-based PDF parsing are supported; scanned PDFs may not produce usable text.
- Natural-language requests are not unlimited: some requests may need clearer column names or rephrasing. Start with non-sensitive sample data. Do not send confidential records to an AI provider unless you understand its data policies.
