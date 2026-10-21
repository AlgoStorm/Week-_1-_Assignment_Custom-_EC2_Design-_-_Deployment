# EC2 User Data — AWS AI Cloud Engineers Website

A ready-to-use EC2 User Data script that automatically launches a simple multi-page website on Amazon Linux 2023.  
The site includes three static pages plus one dynamic PHP page that adds two numbers (useful for quick “instances × cost” style calculations).

**Theme:** AWS AI Cloud Engineers 🚀

---

## What This Does

When you paste the script into an EC2 instance’s **User Data** field (or a Launch Template) and launch an **Amazon Linux 2023** instance, the instance will:

1. Update packages
2. Install Apache (`httpd`) and PHP
3. Start and enable the web server
4. Create four web pages under `/var/www/html/`
5. Serve a working site on port 80

### Pages Created

| File              | Type    | Description                                      |
|-------------------|---------|--------------------------------------------------|
| `index.html`      | Static  | Home / welcome page                              |
| `about.html`      | Static  | About the “AWS AI Cloud Engineers” theme         |
| `services.html`   | Static  | List of services                                 |
| `calculator.php`  | Dynamic | Form that adds two numbers and displays the sum  |

---

## Prerequisites

- AWS account with permissions to launch EC2 instances
- **Amazon Linux 2023** AMI
- Security Group that allows inbound **TCP port 80** (HTTP)
- Optional: SSH access (port 22) if you want to inspect the instance

---

## How to Use

### Option 1: Launch Template (Recommended)

1. Create or edit an EC2 Launch Template.
2. Choose **Amazon Linux 2023**.
3. Under **Advanced details → User data**, paste the entire contents of `seir_ec2_userdata.sh` (or the script below).
4. Make sure the security group allows port 80.
5. Launch the instance from the template.

### Option 2: Direct Launch

1. Launch a new EC2 instance.
2. Select Amazon Linux 2023.
3. Expand **Advanced details** and paste the User Data script.
4. Launch and wait for the instance to pass status checks.

After launch, open a browser to:

```
http://<public-ipv4-address>/
```

---

## Files in This Repo

```
.
├── README.md
├── seir_ec2_userdata.sh   # The User Data script
└── screenshots/           # Optional: add screenshots of the running site
```

---

## Script Overview

The script:

- Uses `dnf` (Amazon Linux 2023 package manager)
- Installs `httpd` and `php`
- Writes the four HTML/PHP files with heredocs
- Sets correct ownership (`apache:apache`) and permissions
- Restarts Apache

The dynamic page (`calculator.php`) accepts two numbers via a form and returns their sum. It is intentionally simple so the focus stays on the User Data automation.

---

## Cleanup

When you are finished testing:

1. Terminate the EC2 instance(s).
2. Keep the Launch Template if you want to reuse it.
3. Do **not** leave running instances if you only need them for a demo.

---

## Notes

- User Data runs only on the **first boot**.
- If something fails, SSH into the instance and check `/var/log/cloud-init-output.log`.
- The site is intentionally minimal — no CSS frameworks, no databases, no external dependencies.
- Public IPv4 addresses are assigned by AWS and may be reused; always verify the address after launch.

---

## License

This example is provided for educational and demonstration purposes. Use and modify freely.
