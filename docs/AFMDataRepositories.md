---
layout: default
title: AFM Data Repositories
---

<style>
  body {
    background-color: black;
    color: white;
    font-family: Arial, sans-serif;
  }
  a { color: white; text-decoration: underline; }
  h1, h2 {
    color: #FFA500;
    border-bottom: 2px solid #FFA500;
    padding-bottom: 5px;
    margin-top: 40px;
  }
  label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
  }
  input, textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    background-color: #222;
    color: white;
    border: 1px solid #555;
    border-radius: 5px;
  }
  input[type="submit"] {
    margin-top: 20px;
    background-color: #04AA6D;
    border: none;
    border-radius: 8px;
    cursor: pointer;
  }
  input[type="submit"]:hover {
    background-color: #038f5d;
  }
  .repo-entry {
    margin-bottom: 20px;
  }
  .repo-entry strong {
    color: #04AA6D;
  }
</style>

<h1>Online AFM Data Repositories</h1>

<form id="repoForm">
  <label for="category">Category</label>
  <select id="category" name="category" required>
    <option value="">-- Select Category --</option>
    <option value="Bio-AFM Images">Bio-AFM Images</option>
    <option value="High-Speed AFM Videos">High-Speed AFM Videos</option>
    <option value="Material Images">Material Images</option>
  </select>

  <label for="title">Repository Name</label>
  <input type="text" id="title" name="title" required>

  <label for="link">Link</label>
  <input type="text" id="link" name="link" required>

  <label for="desc">Short Description</label>
  <textarea id="desc" name="desc" rows="3" required></textarea>

  <input type="submit" value="Submit Repository">
</form>

<hr>

<h2>Bio-AFM Images</h2>
<div id="Bio-AFM Images"></div>

<h2>High-Speed AFM Videos</h2>
<div id="High-Speed AFM Videos"></div>

<h2>Material Images</h2>
<div id="Material Images"></div>

<script>
  const SCRIPT_URL = "https://script.google.com/macros/s/AKfycbzL5EaQKr0WilFq8KyF_ldQGAUew36qN3JB2QHd73lt38iAuTY-qmOX_7a7OLjnnfVJ/exec"; // ← Replace with your Apps Script URL

  document.getElementById('repoForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const category = document.getElementById('category').value;
    const title = document.getElementById('title').value.trim();
    const link = document.getElementById('link').value.trim();
    const desc = document.getElementById('desc').value.trim();

    // Add entry to page
    const entry = document.createElement('div');
    entry.classList.add('repo-entry');
    entry.innerHTML = `
      <strong>${title}</strong><br>
      <a href="${link}" target="_blank">${link}</a><br>
      <em>${desc}</em>
    `;
    document.getElementById(category).appendChild(entry);

    // Save to Google Sheets
    fetch(SCRIPT_URL, {
      method: 'POST',
      body: JSON.stringify({ category, title, link, desc }),
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Submitted:", data);
    })
    .catch(error => {
      console.error("Error submitting:", error);
    });

    e.target.reset();
  });
</script>
