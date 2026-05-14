#!/bin/bash

# Mirror specific paths (Docs and Assets) into a local 'offline_docs' directory
httrack \
  "https://www.openproject.org/docs/" \
  -O "./offline_docs" \
  "-*" \
  "+*.openproject.org/docs/*" \
  "+*.openproject.org/assets/*"

# Download only PDF files found within the docs into a 'pdf_files' directory
httrack \
  "https://www.openproject.org/docs/" \
  -O "./pdf_files" \
  "-*" \
  "+*.pdf"

# Mirror the entire docs site completely for offline browsing
httrack \
  "https://www.openproject.org/docs/" \
  -O "./full_mirror"
