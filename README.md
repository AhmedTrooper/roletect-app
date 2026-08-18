# RoleTect

<div align="center">

**The Privacy-First AI Job Application Vault & Offline LaTeX IDE**

[![Official Website](https://img.shields.io/badge/Official%20Site-roletect.vercel.app-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://roletect.vercel.app/)
[![Firefox Add-on](https://img.shields.io/badge/Firefox-Add--on-FF7139?style=for-the-badge&logo=firefox-browser&logoColor=white)](https://addons.mozilla.org/en-US/firefox/addon/roletect-ingest/)
[![GitHub Issues](https://img.shields.io/github/issues/AhmedTrooper/roletect-app?style=for-the-badge&logo=github)](https://github.com/AhmedTrooper/roletect-app/issues)
[![License](https://img.shields.io/badge/License-Apache_2.0-22c55e?style=for-the-badge)](LICENSE)

<br/>

### 🛒 [Get RoleTect (roletect.vercel.app)](https://roletect.vercel.app/) &nbsp;|&nbsp; 📥 [Desktop Releases](https://github.com/AhmedTrooper/roletect-app/releases) &nbsp;|&nbsp; 💡 [Request a Feature](https://github.com/AhmedTrooper/roletect-app/issues/new?labels=enhancement&template=feature_request.md) &nbsp;|&nbsp; 🐛 [Report a Bug](https://github.com/AhmedTrooper/roletect-app/issues/new?labels=bug&template=bug_report.md)

</div>

---

## 📢 About This Repository

> **Notice:** **RoleTect** is proprietary, privacy-focused software. The core engine and desktop application are maintained in a private repository. This public repository (`roletect-app`) is the official community and release hub for:
>
> * 🛒 **Official Website & Store:** Learn more and purchase RoleTect licenses at [https://roletect.vercel.app/](https://roletect.vercel.app/).
> * 🐛 **Issue Tracking & Bug Reports:** Report bugs, crashes, and platform compatibility issues.
> * 💡 **Feature Requests & Suggestions:** Propose new features, AI integrations, and UI enhancements.
> * 📦 **Desktop Releases & Quick Installers:** Download official application binaries and installation scripts for Linux, macOS, and Windows.
> * 🚀 **Roadmap & Updates:** Track progress on upcoming releases, including the multi-user VPS / Cloud collaborative edition.

---

## 🌟 What is RoleTect?

**RoleTect** is a local-first, privacy-focused LaTeX IDE and job application toolkit designed for engineers, researchers, and professionals who demand complete control over their documents and data.

RoleTect integrates embedded offline LaTeX compilation, intelligent DOM web ingestion, and self-healing multi-provider AI into a unified workflow—streamlining everything from parsing job descriptions to engineering pixel-perfect, tailored LaTeX resumes without cloud lock-in.

---

## ⚡ Key Features

### 🛡️ Zero-Trust Security & Local-First Privacy
* **Local Data Sovereignty:** Resumes, job history, and personal data are stored on-device in your local SQLite database. No external telemetry or unsolicited tracking.
* **Encrypted Credential Enclave:** API credentials and S3 keys are protected by Argon2 encryption and decrypted in memory only during active inference calls.
* **Direct LLM Connection:** AI API requests travel directly between your machine and your chosen model endpoint over encrypted HTTPS.

### 📄 Embedded Offline Tectonic LaTeX Compiler
* **On-Device PDF Generation:** Embedded Tectonic compiler engine lets you compile complex resumes and documents on-device without installing full multi-gigabyte TeX distributions.
* **Built-in Package Cacher for 100% Offline Compilation:** Includes a dedicated "Initial Cacher" file featuring 85+ essential LaTeX packages (covering core typography, mathematics, physics, engineering, computer science, and page layouts). Running this once automatically populates your local Tectonic cache so all subsequent document and resume compilations run completely offline.
* **Live Side-by-Side LaTeX Editor:** Interactive CodeMirror editor with real-time compilation, diagnostics, and smooth PDF streaming.
* **Section-Wide Self-Healing AI:** If your custom code triggers compiler errors, the built-in AI debugger analyzes the raw Tectonic logs and provides instant one-click auto-repairs directly inside the compiler tab.

### 🧩 Companion Browser Extension & Token-Squashing Pipeline
* **One-Click Ingestion:** Capture job postings directly from LinkedIn, Indeed, Glassdoor, and any careers portal into your RoleTect vault.
* **Token-Squashing DOM Sanitizer:** Strips away HTML boilerplate, stylesheets, navigation bars, and scripts to extract lean job requirements, saving significant LLM token costs.
* **Local Secure Handshake:** Authenticates directly with the desktop app using a local dynamic-port handshake.

### 🤖 Multi-Provider AI & Self-Healing Resume Tailoring
* **Broad Model Support:** Connect your own API keys for Google Gemini (1.5 Pro / Flash), OpenAI (GPT-4o / GPT-4o-mini), Anthropic Claude (3.5 Sonnet), Groq (Llama 3), and Amazon Bedrock.
* **100% Offline AI with Ollama:** Run open-source models (LLaMA 3, Mistral, DeepSeek) locally on your own GPU/CPU for fully air-gapped workflows.
* **Automated Self-Healing Tailoring:** When tailoring resumes for specific jobs, RoleTect runs self-healing loops—if an AI revision causes a LaTeX syntax error, the system automatically catches the error and repairs the code until it compiles cleanly.
* **Side-by-Side Comparison & Precision Edit:** Compare your baseline resume with tailored versions and use conversational prompts to refine individual bullet points or sections.

### ☁️ Decentralized S3 Cloud Sync
* **Bring Your Own Cloud:** Securely back up and sync your workspace database with any S3-compatible provider (AWS S3, Cloudflare R2, MinIO, Wasabi).
* **Flexible Recovery:** Choose between safe merges or complete database restores across multiple machines.

### 📊 AI-Assisted Technical Diagramming
* **Interactive Mermaid.js Canvas:** Create, edit, and preview flowcharts, sequence diagrams, and architecture designs.
* **Self-Healing Diagram Repair & AI Synthesis:** Generate diagrams from scratch using conversational prompts. If a diagram has broken Mermaid syntax, the one-click AI repair automatically fixes and redraws the visualization.

---

## 🗺️ Upcoming: Cloud & VPS Multi-User Edition

We are actively developing the **RoleTect VPS / Web Edition** for teams and institutions:
* 🌐 **Self-Hosted & VPS Deployment:** Run RoleTect on your private VPS or cloud server.
* 👥 **Multi-User Collaboration:** Team workspaces for shared document templates and hiring pipelines.
* 🔐 **Role-Based Access Control (RBAC):** Granular permission controls for administrators, editors, and viewers.

---

## 🚀 Getting Started & Installation

### 1. Purchase & Licenses
Visit the official website to get started and acquire RoleTect:

👉 **[https://roletect.vercel.app/](https://roletect.vercel.app/)**

---

### 2. Desktop Application Installation

Download the latest application builds from [GitHub Releases](https://github.com/AhmedTrooper/roletect-app/releases) or use our automated single-line installers:

#### 🐧 Linux & 🍎 macOS
Run the unified installer script in your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/AhmedTrooper/roletect-app/main/install.sh | bash
```

#### 🪟 Windows (PowerShell)
Run the installer script in PowerShell:
```powershell
irm https://raw.githubusercontent.com/AhmedTrooper/roletect-app/main/install.ps1 | iex
```

---

### 3. Companion Browser Extension

* 🦊 **Firefox:** Install the official add-on from [Firefox Browser Add-ons](https://addons.mozilla.org/en-US/firefox/addon/roletect-ingest/).
* 🌐 **Chrome / Edge / Brave:** Download `roletect-chrome-extension.zip` from the latest [Release](https://github.com/AhmedTrooper/roletect-app/releases), unpack it, and load it unpacked via `chrome://extensions` (with Developer Mode enabled).

---

## 💬 Community, Issues & Feature Requests

We welcome bug reports, improvements, and feature requests!

* 🐛 **Report a Bug:** [Open a Bug Report](https://github.com/AhmedTrooper/roletect-app/issues/new?labels=bug&template=bug_report.md) with reproduction steps, your OS version, and any relevant logs.
* 💡 **Request a Feature:** [Submit a Feature Request](https://github.com/AhmedTrooper/roletect-app/issues/new?labels=enhancement&template=feature_request.md) with details on your proposed feature or workflow.
* 🔒 **Security Disclosures:** For sensitive security issues, please contact the maintainers directly or open a confidential security advisory.

---

## 📄 License & Attribution

* The public issue templates, documentation, and installer scripts in this repository are licensed under the [Apache License 2.0](LICENSE).
* RoleTect is built using open-source technologies including Tauri, Tectonic, Rig AI, Axum, Vue 3, Pinia, CodeMirror, and Mermaid.js.

---

<div align="center">
  <sub>Built with privacy and precision. Get RoleTect at <a href="https://roletect.vercel.app/">roletect.vercel.app</a>.</sub>
</div>
