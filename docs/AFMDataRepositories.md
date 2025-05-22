<!-- layout: default -->
<!-- title: AFM Repositories -->

<style>
  body {
    background-color: black;
    color: white;
    font-family: Arial, sans-serif;
  }

  h1, h2, h3 {
    color: #FFA500;
    border-bottom: 2px solid #FFA500;
    padding-bottom: 5px;
  }

  a {
    color: white;
    text-decoration: underline;
  }

  .category {
    margin-top: 2em;
  }

  .repo-entry {
    background-color: #222;
    margin: 0.5em 0;
    padding: 1em;
    border-left: 4px solid #04AA6D;
  }

  label, input, textarea, select, button {
    display: block;
    margin-top: 10px;
    width: 100%;
    max-width: 400px;
  }

  button {
    background-color: #04AA6D;
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
  }

  button:hover {
    background-color: #038c59;
  }
</style>

<h1>AFM Data Repositories</h1>
<p>A list of links to data repositories (Zenodo, Figshare…) containing raw AFM data files. To instantly add to the list, please use the form at the bottom of the page.</p>

<!-- Repositories Section -->
<div id="repos">
  <div class="category" id="Bio-AFM Images">
    <h2>Bio-AFM Images</h2>
  </div>
  <div class="category" id="High-Speed AFM Videos">
    <h2>High-Speed AFM Videos</h2>
  </div>
  <div class="category" id="Material Images">
    <h2>Material Images</h2>
  </div>
</div>

<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/11.8.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/11.8.0/firebase-firestore-compat.js"></script>

<script>
  // Firebase config
  const firebaseConfig = {
    apiKey: "AIzaSyAQdiNy5uhJyDJ4gF6qefpya0VLEQuR4A0",
    authDomain: "nanoloczform.firebaseapp.com",
    projectId: "nanoloczform",
    storageBucket: "nanoloczform.appspot.com",
    messagingSenderId: "464412339490",
    appId: "1:464412339490:web:f221918f6f29d56920897b"
  };

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  const db = firebase.firestore();

  // Handle form submission
  document.getElementById('repoForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const category = document.getElementById('category').value;
    const name = document.getElementById('name').value;
    const link = document.getElementById('link').value;
    const description = document.getElementById('description').value;

    // Add repository data to Firestore
    await db.collection('repositories').add({ category, name, link, description });
    alert('Repository submitted successfully!');
    e.target.reset();
    loadRepos();
  });

  // Load and display repos
  async function loadRepos() {
    const snapshot = await db.collection('repositories').get();
    const categories = ['Bio-AFM Images', 'High-Speed AFM Videos', 'Material Images'];

    // Clear existing categories content
    categories.forEach(cat => {
      document.getElementById(cat).innerHTML = `<h2>${cat}</h2>`;
    });

    snapshot.forEach(doc => {
      const data = doc.data();
      const wrapper = document.getElementById(data.category);
      if (wrapper) {
        const div = document.createElement('div');
        div.className = 'repo-entry';
        div.innerHTML = `<strong><a href="${data.link}" target="_blank">${data.name}</a></strong><br>${data.description}`;
        wrapper.appendChild(div);
      }
    });
  }

  // Load repositories when the page loads
  window.onload = loadRepos;
</script>

<!-- Submission Form -->
<h2>Submit a Repository</h2>
<p>Please add links to the existing AFM data repositories containing raw data below. Once submitted, the links will automatically be categorized and displayed under the appropriate section.</p>

<form id="repoForm">
  <label for="category">Category</label>
  <select id="category" required>
    <option value="Bio-AFM Images">Bio-AFM Images</option>
    <option value="High-Speed AFM Videos">High-Speed AFM Videos</option>
    <option value="Material Images">Material Images</option>
  </select>

  <label for="name">Repository Name</label>
  <input type="text" id="name" required>

  <label for="link">URL</label>
  <input type="url" id="link" required>

  <label for="description">Description</label>
  <textarea id="description" required></textarea>

  <button type="submit">Submit</button>
</form>
