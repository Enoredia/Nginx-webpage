#!/bin/bash

# Exit if any command fails
set -e

echo "Updating package list..."
sudo apt update -y

echo "Installing Nginx..."
sudo apt install -y nginx

echo "Creating custom HTML page..."
sudo bash -c 'cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .card {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
        }

        h1 {
            margin-bottom: 10px;
            color: #4e73df;
        }

        p {
            font-size: 18px;
            margin-top: 0;
        }

        .status {
            margin-top: 20px;
            padding: 10px;
            background: #e3fcef;
            color: #2e7d32;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="card">
        <h1> Welcome to Blessing Nginx Server</h1>
        <p>The server is successfully configured and running.</p>
        <div class="status">Nginx is Active ✔</div>
    </div>

</body>
</html>
EOF'

echo "Starting and enabling Nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

if systemctl is-active --quiet nginx; then
    echo "SUCCESS: Nginx is running."
else
    echo "ERROR: Nginx failed to start."
    exit 1
fi
