#!/bin/bash
set -e

# Update and install Apache + PHP
dnf update -y
dnf install -y httpd php

# Start and enable Apache
systemctl enable --now httpd

# Set permissions for the web root
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Create Home page
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>AWS AI Cloud Engineers</title>
  <style>
    body { font-family: Arial, sans-serif; background: #232f3e; color: #fff; text-align: center; margin: 0; padding: 40px; }
    h1 { color: #ff9900; font-size: 2.5em; }
    nav a { color: #ff9900; margin: 0 15px; text-decoration: none; font-weight: bold; }
    nav a:hover { text-decoration: underline; }
    .container { max-width: 800px; margin: auto; }
  </style>
</head>
<body>
  <div class="container">
    <h1>🚀 AWS AI Cloud Engineers 🚀</h1>
    <p>We launch custom websites on EC2 with User Data — like this one!</p>
    <nav>
      <a href="index.html">Home</a>
      <a href="about.html">About</a>
      <a href="services.html">Services</a>
      <a href="calculator.php">Calculator</a>
    </nav>
    <hr>
    <p>This site was bootstrapped automatically via EC2 User Data.<br>
    Excited yet? We are!</p>
  </div>
</body>
</html>
EOF

# Create About page
cat > /var/www/html/about.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>About Us | AWS AI Cloud Engineers</title>
  <style>
    body { font-family: Arial, sans-serif; background: #232f3e; color: #fff; text-align: center; margin: 0; padding: 40px; }
    h1 { color: #ff9900; }
    nav a { color: #ff9900; margin: 0 15px; text-decoration: none; font-weight: bold; }
    .container { max-width: 800px; margin: auto; }
  </style>
</head>
<body>
  <div class="container">
    <h1>About AWS AI Cloud Engineers</h1>
    <nav>
      <a href="index.html">Home</a>
      <a href="about.html">About</a>
      <a href="services.html">Services</a>
      <a href="calculator.php">Calculator</a>
    </nav>
    <hr>
    <p>We are a team of passionate AWS cloud engineers who love automating everything — especially launching cool websites with EC2 User Data scripts.</p>
    <p>Our mission: Make infrastructure as code fun, fast, and a little bit exciting.</p>
    <p>Built with Apache + PHP on Amazon Linux 2023.</p>
  </div>
</body>
</html>
EOF

# Create Services page
cat > /var/www/html/services.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Services | AWS AI Cloud Engineers</title>
  <style>
    body { font-family: Arial, sans-serif; background: #232f3e; color: #fff; text-align: center; margin: 0; padding: 40px; }
    h1 { color: #ff9900; }
    nav a { color: #ff9900; margin: 0 15px; text-decoration: none; font-weight: bold; }
    .container { max-width: 800px; margin: auto; text-align: left; }
  </style>
</head>
<body>
  <div class="container">
    <h1 style="text-align:center;">Our Services</h1>
    <nav style="text-align:center;">
      <a href="index.html">Home</a>
      <a href="about.html">About</a>
      <a href="services.html">Services</a>
      <a href="calculator.php">Calculator</a>
    </nav>
    <hr>
    <ul>
      <li>EC2 User Data automation & website bootstrapping</li>
      <li>Simple multi-page static + dynamic sites</li>
      <li>Apache + PHP setups on Amazon Linux</li>
      <li>Infrastructure as Code demos and rapid prototyping</li>
      <li>Cloud cost calculators (see our dynamic page!)</li>
    </ul>
    <p style="text-align:center;">Need something custom? We can script it!</p>
  </div>
</body>
</html>
EOF

# Create dynamic Calculator page (PHP)
cat > /var/www/html/calculator.php << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Cloud Calculator | AWS AI Cloud Engineers</title>
  <style>
    body { font-family: Arial, sans-serif; background: #232f3e; color: #fff; text-align: center; margin: 0; padding: 40px; }
    h1 { color: #ff9900; }
    nav a { color: #ff9900; margin: 0 15px; text-decoration: none; font-weight: bold; }
    form { margin: 30px auto; max-width: 400px; }
    input[type="number"] { width: 100%; padding: 10px; margin: 10px 0; border: none; border-radius: 4px; }
    input[type="submit"] { background: #ff9900; color: #232f3e; border: none; padding: 12px 24px; font-size: 1em; border-radius: 4px; cursor: pointer; }
    .result { background: #1a252f; padding: 20px; border-radius: 8px; margin-top: 20px; }
  </style>
</head>
<body>
  <h1>Instance / Cost Calculator</h1>
  <nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="services.html">Services</a>
    <a href="calculator.php">Calculator</a>
  </nav>
  <hr>
  <p>Add two numbers — perfect for quick “number of instances × cost” math!</p>

  <form method="post">
    <input type="number" name="num1" step="any" placeholder="Number 1 (e.g. instances)" required>
    <input type="number" name="num2" step="any" placeholder="Number 2 (e.g. cost per instance)" required>
    <input type="submit" value="Calculate Sum">
  </form>

  <?php
  if ($_SERVER["REQUEST_METHOD"] == "POST") {
      $num1 = floatval($_POST['num1']);
      $num2 = floatval($_POST['num2']);
      $sum = $num1 + $num2;
      echo "<div class='result'><h2>Result: " . htmlspecialchars($num1) . " + " . htmlspecialchars($num2) . " = <strong>$sum</strong></h2></div>";
  }
  ?>
</body>
</html>
EOF

# Ensure ownership and restart Apache
chown -R apache:apache /var/www/html
systemctl restart httpd

echo "Website launched successfully!"
