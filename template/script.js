document.getElementById('idForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const name = document.getElementById('name').value;
    const designation = document.getElementById('designation').value;
    const photoInput = document.getElementById('photo');
    const canvas = document.getElementById('idCanvas');
    const ctx = canvas.getContext('2d');

    // Clear previous card
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Background
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Text
    ctx.fillStyle = '#000000';
    ctx.font = '16px Arial';
    ctx.fillText('Name: ' + name, 10, 30);
    ctx.fillText('Designation: ' + designation, 10, 60);

    // Load and draw photo
    const reader = new FileReader();
    reader.onload = function (event) {
        const img = new Image();
        img.onload = function () {
            ctx.drawImage(img, 10, 80, 80, 80);
        };
        img.src = event.target.result;
    };
    reader.readAsDataURL(photoInput.files[0]);
});
