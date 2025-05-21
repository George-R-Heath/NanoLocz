---
layout: default
title: Online AFM Data Repositories
---

<style>
  body {
    background-color: black;
    color: white;
    font-family: Arial, sans-serif;
  }

  a {
    color: white;
    text-decoration: underline;
  }

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

  input[type="text"], textarea {
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
    color: white;
    padding: 10px 20px;
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

<p>Know of a good dataset repo? Submit it here. It will appear below instantly. (Note: submissions aren’t saved on refresh.)</p>

<form id="repoForm">
  <label for="category">Category (e.g. Institutional, Community, Calibration)</label>
  <input type="text" id="category" name="category" required>

  <label for="title">Repository Name</label>
  <input type="text" id="title" name="title" required>

  <label for="link">Link</label>
  <input type="text" id="link" name="link" required>

  <label for="desc">Short Description</label>
  <textarea id="desc" name="desc" rows="3" required></textarea>

  <input type="submit" value="Submit Repository">
</form>

<hr>

<h2>Institutional Repositories</h2>
<div id="Institutional"></div>

<h2>Community Platforms</h2>
<div id="Community"></div>

<h2>Calibration & Examples</h2>
<div id="Calibration"></div>

<script>
  document.getElementById('repoForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const category = document.getElementById('category').value.trim();
    const title = document.getElementById('title').value.trim();
    const link = document.getElementById('link').value.trim();
    const desc = document.getElementById('desc').value.trim();

    const newEntry = document.createElement('div');
    newEntry.classList.add('repo-entry');
    newEntry.innerHTML = `
      <strong>${title}</strong><br>
      <a href="${link}" target="_blank">${link}</a><br>
      <em>${desc}</em>
    `;

    // Decide where to insert the entry
    const key = category.toLowerCase();
    let container = null;

    if (key.includes('institution')) container = document.getElementById('Institutional');
    else if (key.includes('community')) container = document.getElementById('Community');
    else if (key.includes('calibration')) container = document.getElementById('Calibration');
    else {
      // Unknown category: create a new section
      const newHeading = document.createElement('h2');
      newHeading.textContent = category;
      newHeading.id = category;
      document.body.appendChild(newHeading);

      container = document.createElement('div');
      container.id = category;
      document.body.appendChild(container);
    }

    container.appendChild(newEntry);
    e.target.reset(); // Clear the form
  });
</script>
